Return-Path: virtio-dev-return-7037-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 586D4985F51
	for <virtio-dev@lists.oasis-open.org>; Thu,  9 Apr 2020 14:43:21 +0000 (UTC)
References: <20200408225302.18764.209.stgit@localhost.localdomain>
 <20200408225523.18764.86514.stgit@localhost.localdomain>
 <a461c334-79f0-a638-962e-d6b136707ce3@redhat.com>
 <CAKgT0Ueu4P4Z-fNZiEnHDV2nCSrW7qJWVD17=VLHt_Le00NSWg@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <c4b7653e-523b-5fcc-9ef2-8559c438867c@redhat.com>
Date: Thu, 9 Apr 2020 16:43:09 +0200
MIME-Version: 1.0
In-Reply-To: <CAKgT0Ueu4P4Z-fNZiEnHDV2nCSrW7qJWVD17=VLHt_Le00NSWg@mail.gmail.com>
Content-Language: en-US
Subject: [virtio-dev] Re: [PATCH v18 QEMU 2/3] virtio-balloon: Add support for providing
 free page reports to host
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
List-ID: <virtio-dev.lists.oasis-open.org>

On 09.04.20 16:41, Alexander Duyck wrote:
> On Thu, Apr 9, 2020 at 12:36 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 09.04.20 00:55, Alexander Duyck wrote:
>>> From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
>>>
>>> Add support for the page reporting feature provided by virtio-balloon.
>>> Reporting differs from the regular balloon functionality in that is is
>>> much less durable than a standard memory balloon. Instead of creating a
>>> list of pages that cannot be accessed the pages are only inaccessible
>>> while they are being indicated to the virtio interface. Once the
>>> interface has acknowledged them they are placed back into their respective
>>> free lists and are once again accessible by the guest system.
>>>
>>> Unlike a standard balloon we don't inflate and deflate the pages. Instead
>>> we perform the reporting, and once the reporting is completed it is
>>> assumed that the page has been dropped from the guest and will be faulted
>>> back in the next time the page is accessed.
>>>
>>> This patch is a subset of the UAPI patch that was submitted for the Linux
>>> kernel. The original patch can be found at:
>>> https://lore.kernel.org/lkml/20200211224657.29318.68624.stgit@localhost.localdomain/
>>
>> You don't need all these comments.
> 
> Sorry about that. Those are basically the same comments from the
> original upstream patch. I just wasn't aware of the process so I just
> copied that over and added the comment/link to the original patch.

No worries, it just felt like "oh, he spent a lot of time writing this,
but after all it wasn't necessary" :)

-- 
Thanks,

David / dhildenb


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

