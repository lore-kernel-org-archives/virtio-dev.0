Return-Path: virtio-dev-return-7084-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C4357986014
	for <virtio-dev@lists.oasis-open.org>; Thu, 16 Apr 2020 18:34:05 +0000 (UTC)
References: <CAKgT0UcaBfyKdTPErOxxLJgShOaJNfo9Maqps0ufABMbAo0iuQ@mail.gmail.com>
 <EDD25A47-8A8D-4F9B-9875-B983A1BA72C2@redhat.com>
 <CAKgT0Uf9a8K50XAS9K39KxBGdNRd5+G7nmkg2PsCHOYHAZ7Xew@mail.gmail.com>
 <f685fa75-6898-4fbe-c2a1-ba35424cb4a2@redhat.com>
 <20200416102229-mutt-send-email-mst@kernel.org>
 <5df12fd8-da98-dd3c-04ef-740189bc48ea@redhat.com>
 <CAKgT0UeVi=xnNxaVE5vB44rDwR4-m305wE671VdaK6R2TM6KGw@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <f6545f81-dab0-2979-ca20-45333ec16e4e@redhat.com>
Date: Thu, 16 Apr 2020 20:33:56 +0200
MIME-Version: 1.0
In-Reply-To: <CAKgT0UeVi=xnNxaVE5vB44rDwR4-m305wE671VdaK6R2TM6KGw@mail.gmail.com>
Content-Language: en-US
Subject: [virtio-dev] Re: [PATCH v19 QEMU 1/4] virtio-balloon: Implement support for page
 poison tracking feature
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, "Wang, Wei W" <wei.w.wang@intel.com>, David Hildenbrand <dhildenb@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

> The other thing to keep in mind is that the poison value only really
> comes into play with hinting/reporting. In the case of the standard
> balloon the pages are considered allocated from the guest's

Currently just as free page hinting IMHO. They are temporarily
considered allocated.

> perspective until the balloon is deflated. Then any poison/init will
> occur over again anyway so I don't think the standard balloon should
> really care.

I think we should make this consistent. And as we discuss below, this
allows for a nice optimization in the guest even for ordinary
inflation/deflation (no need to zero out/poison again when giving the
pages back to the buddy).

>=20
> For hinting it somewhat depends. Currently the implementation is
> inflating a balloon so having poisoning or init_on_free means it is
> written to immediately after it is freed so it defeats the purpose of
> the hinting. However that is a Linux implementation issue, not

Yeah, and as we discuss below, we can optimize that later in Linux. It's
sub-optimal, I agree.

> necessarily an issue with the QEMU implementation. As such may be I
> should fix that in the Linux driver since that has been ignored in
> QEMU up until now anyway. The more interesting bit is what should the
> behavior be from the hypervisor when a page is marked as being hinted.
> I think right now the behavior is to just not migrate the page. I
> wonder though if we shouldn't instead just consider the page a zero
> page, and then maybe modify the zero page behavior for the case where
> we know page poisoning is enabled.

I consider that maybe future work. Let's keep it simple for now (iow,
try to get page poisoning handling right first). The optimize the guest
handling on balloon deflation / end of free page hinting.

[...]

>> I can totally understand if Alex would want to stop working on
>> VIRTIO_BALLOON_F_PAGE_POISON at this point and only fix the guest to not
>> enable free page reporting in case we don't have
>> VIRTIO_BALLOON_F_PAGE_POISON (unless that's already done), lol. :)
>=20
> I already have a patch for that.
>=20
> The bigger issue is how to deal with the PAGE_POISON being enabled
> with FREE_PAGE_HINTING. The legacy code at this point is just broken
> and is plowing through with FREE_PAGE_HINTING while it is enabled.
> That is safe for now because it is using a balloon, the side effect is
> that it is going to defer migration. If it switches to a page
> reporting type setup at some point in the future we would need to make
> sure something is written to the other end to identify the poison/zero
> pages.


I think we don't have to worry about that for now. Might be sub-optimal,
but then, I don't think actual page poisoning isn't all that frequently
used in production setups.


--=20
Thanks,

David / dhildenb


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

