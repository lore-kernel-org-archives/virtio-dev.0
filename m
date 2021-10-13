Return-Path: <viresh.kumar@linaro.org>
From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V6 1/2] virtio: i2c: No need to have separate read-write buffers
Date: Wed, 13 Oct 2021 16:34:06 +0530
Message-Id: <4e94a6f093ef8fafe498fb0dd886daca4cda2db1.1634123022.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1634123022.git.viresh.kumar@linaro.org>
References: <cover.1634123022.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
To: "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Jie Deng <jie.deng@intel.com>, Wolfram Sang <wsa@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Jason Wang <jasowang@redhat.com>, Bill Mills <bill.mills@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, virtio-dev@lists.oasis-open.org, stratos-dev@op-lists.linaro.org, Gerd Hoffmann <kraxel@redhat.com>, Arnd Bergmann <arnd@kernel.org>, Arnd Bergmann <arnd@arndb.de>
List-ID: <virtio-dev.lists.oasis-open.org>

The virtio I2C protocol allows to contain multiple read-write requests
in a single I2C transaction using the VIRTIO_I2C_FLAGS_FAIL_NEXT flag,
where each request contains a header, buffer and status.

There is no need to pass both read and write buffers in a single
request, as we have a better way of combining requests into a single I2C
transaction. Moreover, this also limits the transactions to two buffers,
one for read operation and one for write. By using
VIRTIO_I2C_FLAGS_FAIL_NEXT, we don't have any such limits.

Remove support for multiple buffers within a single request.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/112
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Jie Deng <jie.deng@intel.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 virtio-i2c.tex | 54 +++++++++++++++++++-------------------------------
 1 file changed, 20 insertions(+), 34 deletions(-)

diff --git a/virtio-i2c.tex b/virtio-i2c.tex
index 949d75f44158..5d634aec6e7c 100644
--- a/virtio-i2c.tex
+++ b/virtio-i2c.tex
@@ -54,8 +54,7 @@ \subsubsection{Device Operation: Request Queue}\label{sec:Device Types / I2C Ada
 \begin{lstlisting}
 struct virtio_i2c_req {
         struct virtio_i2c_out_hdr out_hdr;
-        u8 write_buf[];
-        u8 read_buf[];
+        u8 buf[];
         struct virtio_i2c_in_hdr in_hdr;
 };
 \end{lstlisting}
@@ -89,11 +88,8 @@ \subsubsection{Device Operation: Request Queue}\label{sec:Device Types / I2C Ada
 Other bits of \field{flags} are currently reserved as zero for future feature
 extensibility.
 
-The \field{write_buf} of the request contains one segment of an I2C transaction
-being written to the device.
-
-The \field{read_buf} of the request contains one segment of an I2C transaction
-being read from the device.
+The \field{buf} of the request contains one segment of an I2C transaction
+being read from or written to the device.
 
 The final \field{status} byte of the request is written by the device: either
 VIRTIO_I2C_MSG_OK for success or VIRTIO_I2C_MSG_ERR for error.
@@ -103,27 +99,18 @@ \subsubsection{Device Operation: Request Queue}\label{sec:Device Types / I2C Ada
 #define VIRTIO_I2C_MSG_ERR    1
 \end{lstlisting}
 
-If ``length of \field{read_buf}''=0 and ``length of \field{write_buf}''>0,
-the request is called write request.
-
-If ``length of \field{read_buf}''>0 and ``length of \field{write_buf}''=0,
-the request is called read request.
-
-If ``length of \field{read_buf}''>0 and ``length of \field{write_buf}''>0,
-the request is called write-read request. It means an I2C write segment followed
-by a read segment. Usually, the write segment provides the number of an I2C
-controlled device register to be read.
-
-The case when ``length of \field{write_buf}''=0, and at the same time,
-``length of \field{read_buf}''=0 doesn't make any sense.
+The virtio I2C protocol supports write-read requests, i.e. an I2C write segment
+followed by a read segment (usually, the write segment provides the number of an
+I2C controlled device register to be read), by grouping a list of requests
+together using the \field{VIRTIO_I2C_FLAGS_FAIL_NEXT} flag.
 
 \subsubsection{Device Operation: Operation Status}\label{sec:Device Types / I2C Adapter Device / Device Operation: Operation Status}
 
-\field{addr}, \field{flags}, ``length of \field{write_buf}'' and ``length of \field{read_buf}''
-are determined by the driver, while \field{status} is determined by the processing
-of the device. A driver puts the data written to the device into \field{write_buf}, while
-a device puts the data of the corresponding length into \field{read_buf} according to the
-request of the driver.
+\field{addr}, \field{flags}, and ``length of \field{buf}'' are determined by the
+driver, while \field{status} is determined by the processing of the device.  A
+driver, for a write request, puts the data to be written to the device into the
+\field{buf}, while a device, for a read request, puts the data read from device
+into the \field{buf} according to the request from the driver.
 
 A driver may send one request or multiple requests to the device at a time.
 The requests in the virtqueue are both queued and processed in order.
@@ -141,11 +128,8 @@ \subsubsection{Device Operation: Operation Status}\label{sec:Device Types / I2C
 
 A driver MUST set the reserved bits of \field{flags} to be zero.
 
-The driver MUST NOT send a request with ``length of \field{write_buf}''=0 and
-``length of \field{read_buf}''=0 at the same time.
-
-A driver MUST NOT use \field{read_buf} if the final \field{status} returned
-from the device is VIRTIO_I2C_MSG_ERR.
+A driver MUST NOT use \field{buf}, for a read request, if the final
+\field{status} returned from the device is VIRTIO_I2C_MSG_ERR.
 
 A driver MUST queue the requests in order if multiple requests are going to
 be sent at a time.
@@ -160,11 +144,13 @@ \subsubsection{Device Operation: Operation Status}\label{sec:Device Types / I2C
 A device SHOULD keep consistent behaviors with the hardware as described in
 \hyperref[intro:I2C]{I2C}.
 
-A device MUST NOT change the value of \field{addr}, reserved bits of \field{flags}
-and \field{write_buf}.
+A device MUST NOT change the value of \field{addr}, and reserved bits of
+\field{flags}.
+
+A device MUST not change the value of the \field{buf} for a write request.
 
-A device MUST place one I2C segment of the corresponding length into \field{read_buf}
-according the driver's request.
+A device MUST place one I2C segment of the ``length of \field{buf}'', for the
+read request, into the \field{buf} according the driver's request.
 
 A device MUST guarantee the requests in the virtqueue being processed in order
 if multiple requests are received at a time.
-- 
2.31.1.272.g89b43f80a514

