Return-Path: <viresh.kumar@linaro.org>
Date: Wed, 1 Sep 2021 11:52:31 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2] virtio: i2c: Allow zero-length transactions
Message-ID: <20210901062231.e5dqa3w4yjs62g7c@vireshk-i7>
References: <bd0f81517c064b333ea5263bacbb74385e0d9b3a.1629107000.git.viresh.kumar@linaro.org>
 <20210831195916-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20210831195916-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Jie Deng <jie.deng@intel.com>, Wolfram Sang <wsa@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Jason Wang <jasowang@redhat.com>, Bill Mills <bill.mills@linaro.org>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, virtio-dev@lists.oasis-open.org, stratos-dev@op-lists.linaro.org, Gerd Hoffmann <kraxel@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On 31-08-21, 20:03, Michael S. Tsirkin wrote:
> But if you are doing it like this, then I think we should
> have conformance clauses that require that the flag
> is consistent with the buffer.

Something like this will work ?

diff --git a/virtio-i2c.tex b/virtio-i2c.tex
index ae344b2bc822..c7335372a8bb 100644
--- a/virtio-i2c.tex
+++ b/virtio-i2c.tex
@@ -145,6 +145,12 @@ \subsubsection{Device Operation: Operation Status}\label{sec:Device Types / I2C
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

-- 
viresh

