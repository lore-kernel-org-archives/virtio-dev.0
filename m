Return-Path: virtio-dev-return-2502-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 9C8FA5818E78
	for <virtio-dev@lists.oasis-open.org>; Tue, 29 Aug 2017 04:58:57 -0700 (PDT)
Message-ID: <59A557B1.7080704@intel.com>
Date: Tue, 29 Aug 2017 20:01:53 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <20170827233033.7afa49b9@fiorina> <20170829095726.GL25960@stefanha-x1.localdomain>
In-Reply-To: <20170829095726.GL25960@stefanha-x1.localdomain>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [Qemu-devel] [RFC] Buffers/caches in VirtIO Balloon driver stats
To: Stefan Hajnoczi <stefanha@gmail.com>, =?UTF-8?B?VG9tw6HFoSBHb2xlbWJpbw==?= =?UTF-8?B?dnNrw70=?= <tgolembi@redhat.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On 08/29/2017 05:57 PM, Stefan Hajnoczi wrote:
> On Sun, Aug 27, 2017 at 11:30:33PM +0200, Tomáš Golembiovský wrote:
>> Hi,
> I have CCed the relevant mailing lists and people most recently involved
> in virtio-balloon discussions.  Hopefully this will help get the right
> people to see your questions.
>
>> We'd like to include information about reclaimable memory into the
>> statistics in VirtiO Balloon driver. Namely, we'd like to include
>> counters for bufferes and caches of Linux kernel. The patch itself is
>> pretty trivial -- no problem there. But before we do that I'd like to
>> get some input from the QEMU community.
>>
>> 1) Is there any reason not to have the stats there?

Could you please share the usages of reclaimable memory via the stats?


>>
>> 2) Considering the balloon device is multiplatform (Linux, BSD,
>> Windows), is there a problem with including buffers/caches? These seem
>> to be specific to the Linux virtual memory subsystem. Of course, other
>> OSes could just report zeros. Are there some internal stats on those
>> OSes that could be filled in? I don't now if such or similar statistic
>> are available on BSD. On Windows only SystemCache stat looks like
>> something relevant. Anyone familiar with those OSes has any suggestions?
>>
>>     

One of the solutions that I'm thinking about is to make virtio 
platform-ware.

That is, the device by default supports
VIRTIO_F_LINUX,
VIRTIO_F_WINDOWS,
VIRTIO_F_BSD.

For the Linux driver, only VIRTIO_F_LINUX is supported, then we can
have Linux specific driver implementations under that feature.


Best,
Wei







---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

