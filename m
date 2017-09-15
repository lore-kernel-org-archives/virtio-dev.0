Return-Path: virtio-dev-return-2542-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 6D3885819211
	for <virtio-dev@lists.oasis-open.org>; Thu, 14 Sep 2017 18:58:32 -0700 (PDT)
Message-ID: <59BB3481.7050909@intel.com>
Date: Fri, 15 Sep 2017 10:01:37 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <20170827233033.7afa49b9@fiorina>	<20170829095726.GL25960@stefanha-x1.localdomain>	<59A557B1.7080704@intel.com> <20170912162947.130c2df2@fiorina>
In-Reply-To: <20170912162947.130c2df2@fiorina>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [Qemu-devel] [RFC] Buffers/caches in VirtIO Balloon driver stats
To: =?UTF-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On 09/12/2017 10:29 PM, Tomáš Golembiovský wrote:
> On Tue, 29 Aug 2017 20:01:53 +0800
> Wei Wang <wei.w.wang@intel.com> wrote:
>
>> On 08/29/2017 05:57 PM, Stefan Hajnoczi wrote:
>>> On Sun, Aug 27, 2017 at 11:30:33PM +0200, Tomáš Golembiovský wrote:
>>>> Hi,
>>> I have CCed the relevant mailing lists and people most recently involved
>>> in virtio-balloon discussions.  Hopefully this will help get the right
>>> people to see your questions.
>>>   
>>>> We'd like to include information about reclaimable memory into the
>>>> statistics in VirtiO Balloon driver. Namely, we'd like to include
>>>> counters for bufferes and caches of Linux kernel. The patch itself is
>>>> pretty trivial -- no problem there. But before we do that I'd like to
>>>> get some input from the QEMU community.
>>>>
>>>> 1) Is there any reason not to have the stats there?
>> Could you please share the usages of reclaimable memory via the stats?
> I'll go ahead then and start sending patches. What would be the proper
> course of action here? Send patch for the driver first, or send patch
> for QEMU first or send both patches right away?

If you have both ready, I think it would be fine to send them all.


>
>
>>>> 2) Considering the balloon device is multiplatform (Linux, BSD,
>>>> Windows), is there a problem with including buffers/caches? These seem
>>>> to be specific to the Linux virtual memory subsystem. Of course, other
>>>> OSes could just report zeros. Are there some internal stats on those
>>>> OSes that could be filled in? I don't now if such or similar statistic
>>>> are available on BSD. On Windows only SystemCache stat looks like
>>>> something relevant. Anyone familiar with those OSes has any suggestions?
>>>>
>>>>        
>> One of the solutions that I'm thinking about is to make virtio
>> platform-ware.
> This is not necessary. IIUC the driver does not need to send all the
> stats. We can simply treat those stats as specific to Linux driver and
> other drivers will not send them. Then QEMU will treat them as if zero
> was reported.

Just had a quick check, I think that should function well too.
QEMU will report -1 for the stats.

Best,
Wei

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

