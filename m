Return-Path: virtio-dev-return-4690-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 72FB6985C07
	for <virtio-dev@lists.oasis-open.org>; Thu, 12 Jul 2018 02:48:06 +0000 (UTC)
Message-ID: <5B46C258.40601@intel.com>
Date: Thu, 12 Jul 2018 10:52:08 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1531215067-35472-1-git-send-email-wei.w.wang@intel.com> <1531215067-35472-2-git-send-email-wei.w.wang@intel.com> <CA+55aFz9a=D-kquM=sG5uhV_HrBAw+VAhcJmtPNz+howy4j9ow@mail.gmail.com> <5B455D50.90902@intel.com> <CA+55aFzqj8wxXnHAdUTiOomipgFONVbqKMjL_tfk7e5ar1FziQ@mail.gmail.com> <20180711092152.GE20050@dhcp22.suse.cz> <CA+55aFwku2tDH4+rfaC67xc4-cEwSrXgnQaci=e2id5ZCRE9JQ@mail.gmail.com> <5B46BB46.2080802@intel.com> <CA+55aFxyv=EUAJFUSio=k+pm3ddteojshP7Radjia5ZRgm53zQ@mail.gmail.com>
In-Reply-To: <CA+55aFxyv=EUAJFUSio=k+pm3ddteojshP7Radjia5ZRgm53zQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH v35 1/5] mm: support to get hints of free page blocks
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Michal Hocko <mhocko@kernel.org>, virtio-dev@lists.oasis-open.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>, KVM list <kvm@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, "Michael S. Tsirkin" <mst@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Paolo Bonzini <pbonzini@redhat.com>, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, Rik van Riel <riel@redhat.com>, peterx@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 07/12/2018 10:30 AM, Linus Torvalds wrote:
> On Wed, Jul 11, 2018 at 7:17 PM Wei Wang <wei.w.wang@intel.com> wrote:
>> Would it be better to remove __GFP_THISNODE? We actually want to get all
>> the guest free pages (from all the nodes).
> Maybe. Or maybe it would be better to have the memory balloon logic be
> per-node? Maybe you don't want to remove too much memory from one
> node? I think it's one of those "play with it" things.
>
> I don't think that's the big issue, actually. I think the real issue
> is how to react quickly and gracefully to "oops, I'm trying to give
> memory away, but now the guest wants it back" while you're in the
> middle of trying to create that 2TB list of pages.

OK. virtio-balloon has already registered an oom notifier 
(virtballoon_oom_notify). I plan to add some control there. If oom happens,
- stop the page allocation;
- immediately give back the allocated pages to mm.

Best,
Wei

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

