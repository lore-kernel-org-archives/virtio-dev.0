Return-Path: virtio-dev-return-7078-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id ED003985FB5
	for <virtio-dev@lists.oasis-open.org>; Thu, 16 Apr 2020 08:36:23 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
References: <CAKgT0UcaBfyKdTPErOxxLJgShOaJNfo9Maqps0ufABMbAo0iuQ@mail.gmail.com>
 <EDD25A47-8A8D-4F9B-9875-B983A1BA72C2@redhat.com>
 <CAKgT0Uf9a8K50XAS9K39KxBGdNRd5+G7nmkg2PsCHOYHAZ7Xew@mail.gmail.com>
 <f685fa75-6898-4fbe-c2a1-ba35424cb4a2@redhat.com>
Message-ID: <265b0361-754e-0a30-1434-4789759b8c64@redhat.com>
Date: Thu, 16 Apr 2020 10:36:14 +0200
MIME-Version: 1.0
In-Reply-To: <f685fa75-6898-4fbe-c2a1-ba35424cb4a2@redhat.com>
Content-Language: en-US
Subject: [virtio-dev] Re: [PATCH v19 QEMU 1/4] virtio-balloon: Implement support for page
 poison tracking feature
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: Alexander Duyck <alexander.duyck@gmail.com>, David Hildenbrand <dhildenb@redhat.com>
Cc: "Wang, Wei W" <wei.w.wang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
List-ID: <virtio-dev.lists.oasis-open.org>

On 16.04.20 10:18, David Hildenbrand wrote:
>>>
>>> Postcopy is a very good point, bought!
>>>
>>> But (what you wrote above) it sounds like that this is really what we *=
have to* do, not an optimization. I=E2=80=98ll double check the spec tomorr=
ow (hopefully it was documented). We should rephrase the comment then.
>>
>> Do you have a link to the spec that I could look at? I am not hopeful
>> that this will be listed there since the poison side of QEMU was never
>> implemented. The flag is only here because it was copied over in the
>> kernel header.
>=20
> Introducing a feature without
>=20
> a) specification what it does
> b) implementation (of both sides) showing what has to be done
> c) any kind of documentation of what needs to be done
>=20
> just horrible.
>=20
> The latest-greatest spec lives in
>=20
> https://github.com/oasis-tcs/virtio-spec.git
>=20
> I can't spot any signs of free page hinting/page poisioning. :(
>=20
> We should document our result of page poisoning, free page hinting, and
> free page reporting there as well. I hope you'll have time for the latter=
.
>=20
> -------------------------------------------------------------------------
> Semantics of VIRTIO_BALLOON_F_PAGE_POISON
> -------------------------------------------------------------------------
>=20
> "The VIRTIO_BALLOON_F_PAGE_POISON feature bit is used to indicate if the
> guest is using page poisoning. Guest writes to the poison_val config
> field to tell host about the page poisoning value that is in use."
> -> Very little information, no signs about what has to be done.
>=20
> "Let the hypervisor know that we are expecting a specific value to be
> written back in balloon pages."
> -> Okay, that talks about "balloon pages", which would include right now
> -- pages "inflated" and then "deflated" using free page hinting
> -- pages "inflated" and then "deflated" using oridnary inflate/deflate
>    queue
> -- pages "inflated" using free page reporting and automatically
>    "deflated" on access
>=20
> So VIRTIO_BALLOON_F_PAGE_POISON really means "whenever the guest
> deflates a page (either explicitly, or implicitly with free page
> reporting), it is filled with "poison_val".
>=20
> And I would add
>=20
> "However, if the inflated page was not filled with "poison_val" when
> inflating, it's not predictable if the original page or a page filled
> with "poison_val" is returned."
>=20
> Which would cover the "we did not discard the page in the hypervisor, so
> the original page is still there".
>=20
>=20
> We should also document what is expected to happen if "poison_val" is
> suddenly changed by the guest at one point in time again. (e.g., not
> supported, unexpected things can happen, etc.) Also, we might have to
> document that a device reset resets the poison_val to 0. (not sure if
> that's really necessary)

Looking at the spec, we will only have to care about
"VIRTIO_BALLOON_F_MUST_TELL_HOST". Especially:

"If the VIRTIO_BALLOON_F_MUST_TELL_HOST feature is negotiated, the
driver MUST NOT use pages from the balloon until the device has
acknowledged the deflate request. Otherwise, if the
VIRTIO_BALLOON_F_MUST_TELL_HOST feature is not negotiated, the driver
MAY begin to re-use pages previously given to the balloon before the
device has acknowledged the deflate request."

So I guess, in QEMU, if
- VIRTIO_BALLOON_F_MUST_TELL_HOST is not set (=3D=3D currently always)
- VIRTIO_BALLOON_F_PAGE_POISON is set
- poison_val is !=3D 0
then, don't discard any pages, because we cannot fill the page reliably
during a deflation request (=3D=3D guest could already be reusing the page
and expecting a certain value).

In QEMU, we should always set VIRTIO_BALLOON_F_MUST_TELL_HOST when
setting VIRTIO_BALLOON_F_PAGE_POISON.

In the spec, we should document that VIRTIO_BALLOON_F_PAGE_POISON should
only be used with VIRTIO_BALLOON_F_MUST_TELL_HOST or sth like that ...

confusing stuff. Let me know what you think.


--=20
Thanks,

David / dhildenb


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

