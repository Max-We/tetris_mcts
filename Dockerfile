# Start with NVIDIA PyTorch image
FROM nvcr.io/nvidia/pytorch:20.01-py3

# Set working directory
WORKDIR /app

# Install Python dependencies (same as in requirements.txt but without torch, pytetris, caffe2)
RUN pip install --no-cache-dir --ignore-installed \
    numpy==1.17.2 \
    dash_html_components==1.0.1 \
    matplotlib==3.1.1 \
    dash==1.4.1 \
    plotly==4.3.0 \
    cppimport==18.11.8 \
    tables==3.5.2 \
    numba==0.45.1 \
    tqdm==4.36.1 \
    dash_core_components==1.3.1 \
    yattag==1.12.2 \
    Pillow==7.2.0

# Install additional system dependencies
RUN apt-get update && apt-get install -y \
    libhdf5-dev \
    && rm -rf /var/lib/apt/lists/*

# Install llvmlite
RUN pip install --no-cache-dir llvmlite==0.29.0

# Clone and install pyTetris
RUN git clone https://github.com/hrpan/pyTetris.git && \
    cd pyTetris && \
    pip install --no-cache-dir  .

# Copy application code
COPY . .

# Set the default command to run your application
#CMD ["python", "play.py", "--agent_type", "ValueSimLP", "--online", "--ngames", "1000", "--mcts_sims", "100"]
