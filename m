Return-Path: <viresh.kumar@linaro.org>
From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] virtio: i2c: Allow buffer less transactions
Date: Fri, 23 Jul 2021 10:56:09 +0530
Message-Id: <cd02a45c16631d92d864fbf432bf0b2865b7de12.1627017387.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
To: "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Jie Deng <jie.deng@intel.com>, Wolfram Sang <wsa@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Jason Wang <jasowang@redhat.com>, Bill Mills <bill.mills@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, virtio-dev@lists.oasis-open.org, Gerd Hoffmann <kraxel@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

The I2C protocol allows requests with no data, like the SMBus Quick
command, where the command is inferred based on the read/write flag
itself.

In order to allow such a request, allocate another bit,
VIRTIO_I2C_FLAGS_M_RD(1), in the flags to pass the request type, as read
or write. This was earlier done using the read/write permission to the
buffer itself.

This still won't work well if multiple buffers are passed for the same
request, i.e. the write-read requests, as the VIRTIO_I2C_FLAGS_M_RD flag
can only be used with a single buffer.

Coming back to it, there is no need to send multiple buffers with a
single request. All we need, is a way to group several requests
together, which we can already do based on the
VIRTIO_I2C_FLAGS_FAIL_NEXT flag.

Remove support for multiple buffers within a single request.

Since we are at very early stage of development currently, we can do
these modifications without addition of new features or versioning of
the protocol.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
Hi Guys,

I did try to follow the discussion you guys had during V4, where we added
support for multiple buffers for the same request, which I think is unnecessary
now, after introduction of the VIRTIO_I2C_FLAGS_FAIL_NEXT flag.

https://lists.oasis-open.org/archives/virtio-comment/202011/msg00005.html

And so starting this discussion again, because we need to support stuff like:
i2cdetect -q <i2c-bus-number>, which issues a SMBus Quick command.

 virtio-i2c.tex | 60 ++++++++++++++++++++++++--------------------------
 1 file changed, 29 insertions(+), 31 deletions(-)

diff --git a/virtio-i2c.tex b/virtio-i2c.tex
index 949d75f44158..338efb428d92 100644
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
@@ -84,16 +83,16 @@ \subsubsection{Device Operation: Request Queue}\label{sec:Device Types / I2C Ada
     and sets it on the other requests. If this bit is set and a device fails
     to process the current request, it needs to fail the next request instead
     of attempting to execute it.
+
+\item[VIRTIO_I2C_FLAGS_M_RD(1)] is used to mark the request as READ or WRITE.
 \end{description}
 
 Other bits of \field{flags} are currently reserved as zero for future feature
 extensibility.
 
-The \field{write_buf} of the request contains one segment of an I2C transaction
-being written to the device.
-
-The \field{read_buf} of the request contains one segment of an I2C transaction
-being read from the device.
+The \field{buf} of the request is optional and contains one segment of an I2C
+transaction being read from or written to the device, based on the value of the
+\field{VIRTIO_I2C_FLAGS_M_RD} bit in the \field{flags} field.
 
 The final \field{status} byte of the request is written by the device: either
 VIRTIO_I2C_MSG_OK for success or VIRTIO_I2C_MSG_ERR for error.
@@ -103,27 +102,27 @@ \subsubsection{Device Operation: Request Queue}\label{sec:Device Types / I2C Ada
 #define VIRTIO_I2C_MSG_ERR    1
 \end{lstlisting}
 
-If ``length of \field{read_buf}''=0 and ``length of \field{write_buf}''>0,
-the request is called write request.
+If \field{VIRTIO_I2C_FLAGS_M_RD} bit is set in the \field{flags}, then the
+request is called a read request.
 
-If ``length of \field{read_buf}''>0 and ``length of \field{write_buf}''=0,
-the request is called read request.
+If \field{VIRTIO_I2C_FLAGS_M_RD} bit is unset in the \field{flags}, then the
+request is called a write request.
 
-If ``length of \field{read_buf}''>0 and ``length of \field{write_buf}''>0,
-the request is called write-read request. It means an I2C write segment followed
-by a read segment. Usually, the write segment provides the number of an I2C
-controlled device register to be read.
+The \field{buf} is optional and may not be present for some of the requests,
+like SMBus Quick.
 
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
@@ -141,11 +140,8 @@ \subsubsection{Device Operation: Operation Status}\label{sec:Device Types / I2C
 
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
@@ -160,11 +156,13 @@ \subsubsection{Device Operation: Operation Status}\label{sec:Device Types / I2C
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

