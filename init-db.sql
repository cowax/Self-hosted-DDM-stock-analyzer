-- Create schema for DDM calculations
CREATE SCHEMA IF NOT EXISTS ddm;

-- Historical calculations storage
CREATE TABLE IF NOT EXISTS ddm.analyses (
    id SERIAL PRIMARY KEY,
    ticker VARCHAR(10) NOT NULL,
    analysis_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    current_price DECIMAL(10, 2),
    intrinsic_value DECIMAL(10, 2),
    margin_of_safety DECIMAL(5, 2),
    recommendation VARCHAR(10), -- BUY, HOLD, SELL
    dividend_per_share DECIMAL(10, 2),
    cost_of_equity DECIMAL(5, 2),
    growth_rate DECIMAL(5, 2),
    analysis_notes TEXT
);

-- Store fetched fundamentals
CREATE TABLE IF NOT EXISTS ddm.fundamentals (
    id SERIAL PRIMARY KEY,
    ticker VARCHAR(10),
    fiscal_year INTEGER,
    eps DECIMAL(10, 2),
    revenue BIGINT,
    operating_cash_flow BIGINT,
    free_cash_flow BIGINT,
    total_debt BIGINT,
    equity BIGINT,
    fetch_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Store document parsing results
CREATE TABLE IF NOT EXISTS ddm.documents (
    id SERIAL PRIMARY KEY,
    ticker VARCHAR(10),
    doc_type VARCHAR(50), -- "EARNINGS_REPORT", "DIVIDEND_PROPOSAL"
    filing_date DATE,
    parsed_content TEXT,
    key_metrics JSONB, -- Extracted metrics as JSON
    parse_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_ticker_date ON ddm.analyses(ticker, analysis_date DESC);
CREATE INDEX idx_fundamentals_ticker ON ddm.fundamentals(ticker);
