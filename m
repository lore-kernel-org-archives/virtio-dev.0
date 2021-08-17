Return-Path: <viresh.kumar@linaro.org>
Date: Tue, 17 Aug 2021 16:13:14 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2] virtio: i2c: Allow zero-length transactions
Message-ID: <20210817104314.yg2ybrodkpnfwpoq@vireshk-i7>
References: <bd0f81517c064b333ea5263bacbb74385e0d9b3a.1629107000.git.viresh.kumar@linaro.org>
 <20210816104430-mutt-send-email-mst@kernel.org>
 <20210817035324.r27cdx3yu2j4qmms@vireshk-i7>
 <20210817024607-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20210817024607-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Jie Deng <jie.deng@intel.com>, Wolfram Sang <wsa@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Jason Wang <jasowang@redhat.com>, Bill Mills <bill.mills@linaro.org>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, virtio-dev@lists.oasis-open.org, stratos-dev@op-lists.linaro.org, Gerd Hoffmann <kraxel@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On 17-08-21, 02:47, Michael S. Tsirkin wrote:
> On Tue, Aug 17, 2021 at 09:23:24AM +0530, Viresh Kumar wrote:
> > On 16-08-21, 10:45, Michael S. Tsirkin wrote:
> > > So I wonder. What if we allow zero-length buffers in virtio? Would that
> > > address the need?

> OK, so yea. Let's split this up please.

Just to make sure I understand what you asked for, we are looking for
something on these lines ? And the kernel side will still send an 'sg'
element and call sg_init_one(sg, NULL, 0) ?

diff --git a/packed-ring.tex b/packed-ring.tex
index a9e6c162fe12..cf3af6f42fbd 100644
--- a/packed-ring.tex
+++ b/packed-ring.tex
@@ -163,7 +163,9 @@ \subsection{Element Address and Length}

 In an available descriptor, Element Address corresponds to the
 physical address of the buffer element. The length of the element assumed
-to be physically contiguous is stored in Element Length.
+to be physically contiguous is stored in Element Length. Virtio also
+allows zero-length descriptors, where both address and length of the
+element is set to zero by the driver.

 In a used descriptor, Element Address is unused. Element Length
 specifies the length of the buffer that has been initialized
diff --git a/split-ring.tex b/split-ring.tex
index bfef62d18dab..baf478e4998e 100644
--- a/split-ring.tex
+++ b/split-ring.tex
@@ -175,6 +175,8 @@ \subsection{The Virtqueue Descriptor Table}\label{sec:Basic Facilities of a Virt
 can be chained via \field{next}. Each descriptor describes a
 buffer which is read-only for the device (``device-readable'') or write-only for the device (``device-writable''), but a chain of
 descriptors can contain both device-readable and device-writable buffers.
+Virtio also allows zero-length descriptors, where both \field{addr} and
+\field{len} is set to zero by the driver.

 The actual contents of the memory offered to the device depends on the
 device type.  Most common is to begin the data with a header

-- 
viresh

