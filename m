Return-Path: <viresh.kumar@linaro.org>
From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V5 2/2] virtio: i2c: Allow zero-length transactions
Date: Tue, 12 Oct 2021 16:53:38 +0530
Message-Id: <325276eec77c6ab3bd28382386055b821754396b.1634037711.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1634037711.git.viresh.kumar@linaro.org>
References: <cover.1634037711.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
To: "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Jie Deng <jie.deng@intel.com>, Wolfram Sang <wsa@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Jason Wang <jasowang@redhat.com>, Bill Mills <bill.mills@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, virtio-dev@lists.oasis-open.org, stratos-dev@op-lists.linaro.org, Gerd Hoffmann <kraxel@redhat.com>, Arnd Bergmann <arnd@kernel.org>
List-ID: <virtio-dev.lists.oasis-open.org>

The I2C protocol allows zero-length requests with no data, like the
SMBus Quick command, where the command is inferred based on the
read/write flag itself.

In order to allow such a request, allocate another bit,
VIRTIO_I2C_FLAGS_M_RD(1), in the flags to pass the request type, as read
or write. This was earlier done using the read/write permission to the
buffer itself.

Add a new feature flag for zero length requests and make it mandatory
for it to be implemented, so we don't need to drag the old
implementation around.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/112
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 virtio-i2c.tex | 34 +++++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/virtio-i2c.tex b/virtio-i2c.tex
index 5d634aec6e7c..0e73348963ce 100644
--- a/virtio-i2c.tex
+++ b/virtio-i2c.tex
@@ -17,7 +17,11 @@ \subsection{Virtqueues}\label{sec:Device Types / I2C Adapter Device / Virtqueues
 
 \subsection{Feature bits}\label{sec:Device Types / I2C Adapter Device / Feature bits}
 
-None currently defined.
+\begin{description}
+\item[VIRTIO_I2C_F_ZERO_LENGTH_REQUEST (0)] The device supports zero-length I2C
+request and \field{VIRTIO_I2C_FLAGS_M_RD} flag. It is mandatory to implement
+this feature.
+\end{description}
 
 \subsection{Device configuration layout}\label{sec:Device Types / I2C Adapter Device / Device configuration layout}
 
@@ -83,13 +87,16 @@ \subsubsection{Device Operation: Request Queue}\label{sec:Device Types / I2C Ada
     and sets it on the other requests. If this bit is set and a device fails
     to process the current request, it needs to fail the next request instead
     of attempting to execute it.
+
+\item[VIRTIO_I2C_FLAGS_M_RD(1)] is used to mark the request as READ or WRITE.
 \end{description}
 
 Other bits of \field{flags} are currently reserved as zero for future feature
 extensibility.
 
-The \field{buf} of the request contains one segment of an I2C transaction
-being read from or written to the device.
+The \field{buf} of the request is optional and contains one segment of an I2C
+transaction being read from or written to the device, based on the value of the
+\field{VIRTIO_I2C_FLAGS_M_RD} bit in the \field{flags} field.
 
 The final \field{status} byte of the request is written by the device: either
 VIRTIO_I2C_MSG_OK for success or VIRTIO_I2C_MSG_ERR for error.
@@ -99,6 +106,15 @@ \subsubsection{Device Operation: Request Queue}\label{sec:Device Types / I2C Ada
 #define VIRTIO_I2C_MSG_ERR    1
 \end{lstlisting}
 
+If \field{VIRTIO_I2C_FLAGS_M_RD} bit is set in the \field{flags}, then the
+request is called a read request.
+
+If \field{VIRTIO_I2C_FLAGS_M_RD} bit is unset in the \field{flags}, then the
+request is called a write request.
+
+The \field{buf} is optional and will not be present for a zero-length request,
+like SMBus Quick.
+
 The virtio I2C protocol supports write-read requests, i.e. an I2C write segment
 followed by a read segment (usually, the write segment provides the number of an
 I2C controlled device register to be read), by grouping a list of requests
@@ -124,13 +140,23 @@ \subsubsection{Device Operation: Operation Status}\label{sec:Device Types / I2C
 
 \drivernormative{\subsubsection}{Device Operation}{Device Types / I2C Adapter Device / Device Operation}
 
+A driver SHOULD implement the VIRTIO_I2C_F_ZERO_LENGTH_REQUEST feature.
+
 A driver MUST set \field{addr} and \field{flags} before sending the request.
 
 A driver MUST set the reserved bits of \field{flags} to be zero.
 
+A driver MUST NOT send the \field{buf}, for a zero-length request.
+
 A driver MUST NOT use \field{buf}, for a read request, if the final
 \field{status} returned from the device is VIRTIO_I2C_MSG_ERR.
 
+A driver MUST set the \field{VIRTIO_I2C_FLAGS_M_RD} flag for a read operation,
+where the buffer is write-only for the device.
+
+A driver MUST NOT set the \field{VIRTIO_I2C_FLAGS_M_RD} flag for a write
+operation, where the buffer is read-only for the device.
+
 A driver MUST queue the requests in order if multiple requests are going to
 be sent at a time.
 
@@ -141,6 +167,8 @@ \subsubsection{Device Operation: Operation Status}\label{sec:Device Types / I2C
 
 \devicenormative{\subsubsection}{Device Operation}{Device Types / I2C Adapter Device / Device Operation}
 
+A device SHOULD implement the VIRTIO_I2C_F_ZERO_LENGTH_REQUEST feature.
+
 A device SHOULD keep consistent behaviors with the hardware as described in
 \hyperref[intro:I2C]{I2C}.
 
-- 
2.31.1.272.g89b43f80a514

