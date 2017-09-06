Return-Path: virtio-dev-return-2514-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id B24F15818017
	for <virtio-dev@lists.oasis-open.org>; Wed,  6 Sep 2017 07:12:45 -0700 (PDT)
References: <1503734014-239116-1-git-send-email-longpeng2@huawei.com>
 <59A8AE20.1080409@huawei.com>
 <7f0b8eb2-9e5c-7507-191d-1aab17c6ff0f@linux.vnet.ibm.com>
 <20170906164839-mutt-send-email-mst@kernel.org>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Wed, 6 Sep 2017 16:12:29 +0200
MIME-Version: 1.0
In-Reply-To: <20170906164839-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <db000069-7315-012e-d3e2-d0fecbec837f@linux.vnet.ibm.com>
Subject: Re: [virtio-dev] Re: [Qemu-devel] [PATCH v19 0/2] virtio-crypto:
 virtio crypto device specification
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Longpeng (Mike)" <longpeng2@huawei.com>, stefanha@redhat.com, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, luonengjun@huawei.com, cohuck@redhat.com, denglingli@chinamobile.com, Jani.Kokkonen@huawei.com, Ola.Liljedahl@arm.com, Varun.Sethi@freescale.com, xin.zeng@intel.com, brian.a.keating@intel.com, liang.j.ma@intel.com, john.griffin@intel.com, weidong.huang@huawei.com, mike.caraman@nxp.com, agraf@suse.de, jasowang@redhat.com, nmorey@kalray.eu, vincent.jardin@6wind.com, arei.gonglei@hotmail.com, wangxinxin.wang@huawei.com
List-ID: <virtio-dev.lists.oasis-open.org>



On 09/06/2017 03:52 PM, Michael S. Tsirkin wrote:
> On Fri, Sep 01, 2017 at 01:45:45PM +0200, Halil Pasic wrote:
>>
>>
>> On 09/01/2017 02:47 AM, Longpeng (Mike) wrote:
>>> Ping...
>>>
>>> Stefan, Halil, do you have any suggestion ?
>>>
>>
>> Hi Longpeng,
>>
>> I've ran trough your patch, and it reads much better that
>> what I recall v18 used to read like. Because it's been a while
>> since v18 doing a conscious review on this will take a considerable
>> amount of time (my memories of the issues identified back then
>> are very sketchy/vague now). It's on my todo list, but it ain't the
>> only item there.
> 
> I don't think it's a fair reason to delay the merging though.
> No comments in a while says time to merge to me.
> There's always a public review period during which more comments
> can be addressed.
> 

Well, the problem is that there was no new version for a couple
of months. That's why there were no comments.

> So I think we should start a ballot on this one.
> Mike - if you agree please open an issue in TC issue
> tracker.  As a reminder here are the guidelines:
> 

I think, starting a now ballot is a bit rushed: this version is out for
less than two weeks, and there was no substantial feedback. That could be
OK if we had only minor changes in this version, but I don't think that's
the case.

Nevertheless, I'm fine with balloting. Will just have to re-prioritize
myself, have a thorough look, and if in doubt abstain.

Regards,
Halil

> 
> --
> 
> When you open an issue (can be fixed afterwards as well):
> 
> 1. Fill in the reporter in the Environment: field.
> 2. Shortly describe the issue in the description field
>    Preferably add a URL to discussion here or
>    in the comments.
>    If the mail was copied to virtio-comment or virtio-dev, you can use
>         mid.gmane.org/<message-id>
>    to quickly locate a mail in the archives.
> 2. Preferably, fill in all affected versions: in
>    "Affects Version/s:".
>    This might not apply to e.g. improvement requests.
> 
> ---
> 
> When you propose the issue before the TC meeting:
> 
> 1. Mark issue as Open
> 2. Fill in a summary of the final proposed change and
>    link to full proposal in "Proposal"
>    field.
>    [any historical abandoned proposals and extra info can go
>     into comments field]
> ---
> 
> Then mail me and the TC and I will start a ballot.
> 
> Thanks!
> 
>> Btw. I like to have a reference implementation at hand when reviewing
>> a spec. What is the status of the (reference) implementation (I mean
>> the new stuff like stateless/mux)? I think it would be nice to provide
>> this info in the cover letter (e.g. next time, should we need another
>> iteration).
>>
>> Regards,
>> Halil
>>
>>
>> ---------------------------------------------------------------------
>> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
>> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> 
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> 


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

