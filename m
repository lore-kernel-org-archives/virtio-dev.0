Return-Path: virtio-return-3068-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
References: <1523398287-25480-1-git-send-email-pasic@linux.vnet.ibm.com>
 <1523398287-25480-2-git-send-email-pasic@linux.vnet.ibm.com>
 <20180411021955.GG28698@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <58fe7c8a-0d5a-609c-9ee9-2421eae8b649@redhat.com>
Date: Wed, 11 Apr 2018 14:35:23 +0200
MIME-Version: 1.0
In-Reply-To: <20180411021955.GG28698@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="b22KzUquPwerrkXDck1Z2drZ5NhEDcEfs"
Subject: [virtio] Re: [virtio-dev] Re: [virtio] [RFC PATCH 1/3] notifications: unify
 notifications wording in core
To: Stefan Hajnoczi <stefanha@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--b22KzUquPwerrkXDck1Z2drZ5NhEDcEfs
Content-Type: multipart/mixed; boundary="vMii90C9NhkU7n4uV0b4ChjQHY3JxF18J";
 protected-headers="v1"
From: Paolo Bonzini <pbonzini@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>,
 Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Message-ID: <58fe7c8a-0d5a-609c-9ee9-2421eae8b649@redhat.com>
Subject: Re: [virtio-dev] Re: [virtio] [RFC PATCH 1/3] notifications: unify
 notifications wording in core
References: <1523398287-25480-1-git-send-email-pasic@linux.vnet.ibm.com>
 <1523398287-25480-2-git-send-email-pasic@linux.vnet.ibm.com>
 <20180411021955.GG28698@stefanha-x1.localdomain>
In-Reply-To: <20180411021955.GG28698@stefanha-x1.localdomain>

--vMii90C9NhkU7n4uV0b4ChjQHY3JxF18J
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11/04/2018 04:19, Stefan Hajnoczi wrote:
> On Wed, Apr 11, 2018 at 12:11:25AM +0200, Halil Pasic wrote:
>> Let us unify the wording when talking about notifications. This change=

>> establishes the terms available buffer notification for what was usual=
ly
>> simply called notification or virtqueue notification in v1.0 and used
>> buffer notification for what was usually called interrupt.
>>
>> The term configuration change notification in kept where called so and=

>> consolidated where it's called configuration change interrupt or
>> similar.
>>
>> The changes done here are limited to the core part, and don't
>> conceptually involve neither the transports nor the devices (reference=
s
>> are updated though). Future changes should address these parts.
>=20
> Nice, I think the cleanup is worthwhile.

I agree.  I wondered if we should use the term "used buffer interrupt"
and "available buffer notification".  In the common case I think it
would be clearer, though there are cases such as vhost-pci where the
roles are swapped.

Paolo

>>  \begin{lstlisting}
>> -virtq_disable_interrupts(vq);
>> +virtq_disable_notifications(vq);
>=20
> This name is ambiguous.  Only used buffer notifications are disabled,
> not configuration change notifications.
>=20
> How about:
>=20
>   virtq_disable_used_buffer_notifications(vq);
>=20



--vMii90C9NhkU7n4uV0b4ChjQHY3JxF18J--

--b22KzUquPwerrkXDck1Z2drZ5NhEDcEfs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAlrOAQsACgkQv/vSX3jH
roNTpwf+Jj77MkwDH5VRQJLw7C1hkyW1JndOXGAjOExoBQKPGpTWEDG3xzJD+lwI
HO61nICGq2WQrq30qLiVkiyCSUq5BGz2HAf2mvrajiTm/b5IDVqU2x6yAXWIljf0
rflHENTK6F2m4SsHbTIeRAyQdHWqcOWbBJCLhixn9wQwWp9nsm12QIq/GY3SiMaG
/8Q3pzz2FEIK3A2WMHLUKR8yenH7LPHjTfyLWa91J4yEWhMogFIYKK9Qhp2dDOkM
yMtPBKv7clcbk+4GnEs9Ep4G11YfFpOvKU+0IxFi6IT8qhBXP90du7RK1/zR7q6v
j9fa/W/Ec76cFedOf7RR8ERzVGqlRg==
=grc/
-----END PGP SIGNATURE-----

--b22KzUquPwerrkXDck1Z2drZ5NhEDcEfs--
