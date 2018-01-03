Return-Path: virtio-dev-return-2896-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id EC9C858191A8
	for <virtio-dev@lists.oasis-open.org>; Wed,  3 Jan 2018 00:58:15 -0800 (PST)
Message-ID: <5A4C9BAC.3040808@intel.com>
Date: Wed, 03 Jan 2018 17:00:28 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1513685879-21823-5-git-send-email-wei.w.wang@intel.com>	<20171224032121.GA5273@bombadil.infradead.org>	<201712241345.DIG21823.SLFOOJtQFOMVFH@I-love.SAKURA.ne.jp>	<5A3F5A4A.1070009@intel.com>	<20180102132419.GB8222@bombadil.infradead.org> <201801031129.JFC18298.FJMHtOFLVSQOFO@I-love.SAKURA.ne.jp>
In-Reply-To: <201801031129.JFC18298.FJMHtOFLVSQOFO@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH v20 4/7] virtio-balloon: VIRTIO_BALLOON_F_SG
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, willy@infradead.org
Cc: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org, akpm@linux-foundation.org, mawilcox@microsoft.com, david@redhat.com, cornelia.huck@de.ibm.com, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 01/03/2018 10:29 AM, Tetsuo Handa wrote:
> Matthew Wilcox wrote:
>> The radix tree convention is objectively awful, which is why I'm working
>> to change it.  Specifying the GFP flags at radix tree initialisation time
>> rather than allocation time leads to all kinds of confusion.  The preload
>> API is a pretty awful workaround, and it will go away once the XArray
>> is working correctly.  That said, there's no alternative to it without
>> making XBitmap depend on XArray, and I don't want to hold you up there.
>> So there's an xb_preload for the moment.
> I'm ready to propose cvbmp shown below as an alternative to xbitmap (but
> specialized for virtio-balloon case). Wei, can you do some benchmarking
> between xbitmap and cvbmp?
> ----------------------------------------
> cvbmp: clustered values bitmap

I don't think we need to replace xbitmap, at least at this stage. The 
new implementation doesn't look simpler at all, and virtio-balloon has 
worked well with xbitmap.

I would suggest you to send out the new implementation for discussion 
after this series ends, and justify with better performance results if 
you could get.

Best,
Wei



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

