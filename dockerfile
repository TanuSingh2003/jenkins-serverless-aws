# Base AWS Lambda Python image
FROM public.ecr.aws/lambda/python:3.9

# Copy application
COPY app/ ${LAMBDA_TASK_ROOT}

# Install dependencies
RUN pip install -r ${LAMBDA_TASK_ROOT}/requirements.txt --target "${LAMBDA_TASK_ROOT}"

# Command for Lambda
CMD ["app.handler"]

