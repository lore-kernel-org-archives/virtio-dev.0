Return-Path: virtio-dev-return-7082-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A50F5985FD7
	for <virtio-dev@lists.oasis-open.org>; Thu, 16 Apr 2020 14:55:52 +0000 (UTC)
References: <CAKgT0UcaBfyKdTPErOxxLJgShOaJNfo9Maqps0ufABMbAo0iuQ@mail.gmail.com>
 <EDD25A47-8A8D-4F9B-9875-B983A1BA72C2@redhat.com>
 <CAKgT0Uf9a8K50XAS9K39KxBGdNRd5+G7nmkg2PsCHOYHAZ7Xew@mail.gmail.com>
 <f685fa75-6898-4fbe-c2a1-ba35424cb4a2@redhat.com>
 <20200416102229-mutt-send-email-mst@kernel.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <5df12fd8-da98-dd3c-04ef-740189bc48ea@redhat.com>
Date: Thu, 16 Apr 2020 16:55:43 +0200
MIME-Version: 1.0
In-Reply-To: <20200416102229-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Subject: [virtio-dev] Re: [PATCH v19 QEMU 1/4] virtio-balloon: Implement support for page
 poison tracking feature
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, Alexander Duyck <alexander.duyck@gmail.com>, "Wang, Wei W" <wei.w.wang@intel.com>, David Hildenbrand <dhildenb@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

>> We should document our result of page poisoning, free page hinting, and
>> free page reporting there as well. I hope you'll have time for the latte=
r.
>>
>> ------------------------------------------------------------------------=
-
>> Semantics of VIRTIO_BALLOON_F_PAGE_POISON
>> ------------------------------------------------------------------------=
-
>>
>> "The VIRTIO_BALLOON_F_PAGE_POISON feature bit is used to indicate if the
>> guest is using page poisoning. Guest writes to the poison_val config
>> field to tell host about the page poisoning value that is in use."
>> -> Very little information, no signs about what has to be done.
>=20
> I think it's an informational field. Knowing that free pages
> are full of a specific pattern can be handy for the hypervisor
> for a variety of reasons. E.g. compression/deduplication?

I was referring to the documentation of the feature and what we
(hypervisor) are expected to do (in regards to inflation/deflation).

Yes, it might be valuable to know that the guest is using poisoning. I
assume compression/deduplication (IOW KSM) will figure out themselves
that such pages are equal.

>> "Let the hypervisor know that we are expecting a specific value to be
>> written back in balloon pages."
>=20
>=20
>=20
>> -> Okay, that talks about "balloon pages", which would include right now
>> -- pages "inflated" and then "deflated" using free page hinting
>> -- pages "inflated" and then "deflated" using oridnary inflate/deflate
>>    queue
>=20
> ATM, in this case driver calls "free" and that fills page with the
> poison value.

Yes, that's what I mentioned somehwere, it's currently done by Linux and ..=
.

>=20
> It might be a valid optimization to allow driver to skip
> poisoning of freed pages in this case.

... we should prepare for that :)

>=20
>> And I would add
>>
>> "However, if the inflated page was not filled with "poison_val" when
>> inflating, it's not predictable if the original page or a page filled
>> with "poison_val" is returned."
>>
>> Which would cover the "we did not discard the page in the hypervisor, so
>> the original page is still there".
>>
>>
>> We should also document what is expected to happen if "poison_val" is
>> suddenly changed by the guest at one point in time again. (e.g., not
>> supported, unexpected things can happen, etc.)
>=20
> Right. I think we should require that this can only be changed
> before features have been negotiated.
> That is the only point where hypervisor can still fail
> gracefully (i.e. fail FEATURES_OK).

Agreed.

I can totally understand if Alex would want to stop working on
VIRTIO_BALLOON_F_PAGE_POISON at this point and only fix the guest to not
enable free page reporting in case we don't have
VIRTIO_BALLOON_F_PAGE_POISON (unless that's already done), lol. :)

--=20
Thanks,

David / dhildenb


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

