Return-Path: virtio-dev-return-4699-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EC510985507
	for <virtio-dev@lists.oasis-open.org>; Fri, 13 Jul 2018 00:29:20 +0000 (UTC)
Message-ID: <5B47F357.7020202@intel.com>
Date: Fri, 13 Jul 2018 08:33:27 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <CA+55aFz9a=D-kquM=sG5uhV_HrBAw+VAhcJmtPNz+howy4j9ow@mail.gmail.com> <5B455D50.90902@intel.com> <CA+55aFzqj8wxXnHAdUTiOomipgFONVbqKMjL_tfk7e5ar1FziQ@mail.gmail.com> <20180711092152.GE20050@dhcp22.suse.cz> <CA+55aFwku2tDH4+rfaC67xc4-cEwSrXgnQaci=e2id5ZCRE9JQ@mail.gmail.com> <5B46BB46.2080802@intel.com> <CA+55aFxyv=EUAJFUSio=k+pm3ddteojshP7Radjia5ZRgm53zQ@mail.gmail.com> <5B46C258.40601@intel.com> <20180712081317.GD32648@dhcp22.suse.cz> <5B473CB8.1050306@intel.com> <20180712114946.GI32648@dhcp22.suse.cz>
In-Reply-To: <20180712114946.GI32648@dhcp22.suse.cz>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH v35 1/5] mm: support to get hints of free page blocks
To: Michal Hocko <mhocko@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, virtio-dev@lists.oasis-open.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>, KVM list <kvm@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, "Michael S. Tsirkin" <mst@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Paolo Bonzini <pbonzini@redhat.com>, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, Rik van Riel <riel@redhat.com>, peterx@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 07/12/2018 07:49 PM, Michal Hocko wrote:
> On Thu 12-07-18 19:34:16, Wei Wang wrote:
>> On 07/12/2018 04:13 PM, Michal Hocko wrote:
>>> On Thu 12-07-18 10:52:08, Wei Wang wrote:
>>>> On 07/12/2018 10:30 AM, Linus Torvalds wrote:
>>>>> On Wed, Jul 11, 2018 at 7:17 PM Wei Wang <wei.w.wang@intel.com> wrote:
>>>>>> Would it be better to remove __GFP_THISNODE? We actually want to get all
>>>>>> the guest free pages (from all the nodes).
>>>>> Maybe. Or maybe it would be better to have the memory balloon logic be
>>>>> per-node? Maybe you don't want to remove too much memory from one
>>>>> node? I think it's one of those "play with it" things.
>>>>>
>>>>> I don't think that's the big issue, actually. I think the real issue
>>>>> is how to react quickly and gracefully to "oops, I'm trying to give
>>>>> memory away, but now the guest wants it back" while you're in the
>>>>> middle of trying to create that 2TB list of pages.
>>>> OK. virtio-balloon has already registered an oom notifier
>>>> (virtballoon_oom_notify). I plan to add some control there. If oom happens,
>>>> - stop the page allocation;
>>>> - immediately give back the allocated pages to mm.
>>> Please don't. Oom notifier is an absolutely hideous interface which
>>> should go away sooner or later (I would much rather like the former) so
>>> do not build a new logic on top of it. I would appreciate if you
>>> actually remove the notifier much more.
>>>
>>> You can give memory back from the standard shrinker interface. If we are
>>> reaching low reclaim priorities then we are struggling to reclaim memory
>>> and then you can start returning pages back.
>> OK. Just curious why oom notifier is thought to be hideous, and has it been
>> a consensus?
> Because it is a completely non-transparent callout from the OOM context
> which is really subtle on its own. It is just too easy to end up in
> weird corner cases. We really have to be careful and be as swift as
> possible. Any potential sleep would make the OOM situation much worse
> because nobody would be able to make a forward progress or (in)direct
> dependency on MM subsystem can easily deadlock. Those are really hard
> to track down and defining the notifier as blockable by design which
> just asks for bad implementations because most people simply do not
> realize how subtle the oom context is.
>
> Another thing is that it happens way too late when we have basically
> reclaimed the world and didn't get out of the memory pressure so you can
> expect any workload is suffering already. Anybody sitting on a large
> amount of reclaimable memory should have released that memory by that
> time. Proportionally to the reclaim pressure ideally.
>
> The notifier API is completely unaware of oom constrains. Just imagine
> you are OOM in a subset of numa nodes. Callback doesn't have any idea
> about that.
>
> Moreover we do have proper reclaim mechanism that has a feedback
> loop and that should be always preferable to an abrupt reclaim.

Sounds very reasonable, thanks for the elaboration. I'll try with shrinker.

Best,
Wei




---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

