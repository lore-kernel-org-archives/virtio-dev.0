Return-Path: <virtio-comment-return-4230-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Parav Pandit <parav@nvidia.com>
Date: Tue, 14 Feb 2023 00:50:36 +0000
Message-ID: <PH0PR12MB5481340699FC1CD3019B183DDCA29@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230206080210.37758-1-alvaro.karsz@solid-run.com>
 <CAJs=3_C5AqOtaKjk_OWrG+U8SUFLSMez=-6M4JQsh3EEazj-KQ@mail.gmail.com>
 <PH0PR12MB54815E20847C0A5EAF4EEC35DCDE9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CAJs=3_B=veAoNPoLKkqtHcApajVn=82UzVfw63gr7YY+0J3m-w@mail.gmail.com>
 <PH0PR12MB5481B1B2F5648D78C618A92BDCDF9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230212043611-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230212043611-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Subject: [virtio-comment] RE: [virtio-dev] Re: [PATCH v3] virtio-net: Mention
 VIRTIO_NET_F_HASH_REPORT dependency on VIRTIO_NET_F_CTRL_VQ
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Alvaro Karsz <alvaro.karsz@solid-run.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com" <jasowang@redhat.com>, Cornelia Huck <cohuck@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Sunday, February 12, 2023 4:39 AM

[..]
> > This is even better.
> > > Ideally we'll add a "MUST", but since we can't,
> > Lets hear Michael's view, why MUST cannot be done.
> > Based on our discussion here, I think MUST is possible and cleaner with=
out
> breaking any existing sw or device.
>=20
> 1.2 is out without this requirement. Making this a MUST at this point wou=
ld
> declare such previously conformant devices non-conformant.
> So I'm afraid our hands are tied.
>=20
Technically yes, I agree it make non conformant.
The device that offered HASH_REPORT without offering CVQ, is extremely rare=
/narrow case.
I am not sure if anyone would have ever built such a thing just because suc=
h description was missing from the spec.
So, I am inclined towards a practical part than purely technical.

But I can live with SHOULD here if you want to stick to strict compliance h=
ere.

> It might be a good idea to start building out a charter documenting all k=
ind of
> compat hacks like this such that new devices are not tempted to do the wr=
ong
> thing. I am not sure how this will look exactly though.
>=20
We should write a line along with device requirements something like below.

Even though CVQ is not mandatory for HASH_REPORT, it is strong advised the =
device to NOT report this feature when CTRL_VQ is not advertised.

Once there is better section, more generic table etc can be created.
Since you created the ballot already, I will supply the short patch to add =
above description later.

This publicly archived list offers a means to provide input to the=0D
OASIS Virtual I/O Device (VIRTIO) TC.=0D
=0D
In order to verify user consent to the Feedback License terms and=0D
to minimize spam in the list archive, subscription is required=0D
before posting.=0D
=0D
Subscribe: virtio-comment-subscribe@lists.oasis-open.org=0D
Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org=0D
List help: virtio-comment-help@lists.oasis-open.org=0D
List archive: https://lists.oasis-open.org/archives/virtio-comment/=0D
Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf=
=0D
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lis=
ts=0D
Committee: https://www.oasis-open.org/committees/virtio/=0D
Join OASIS: https://www.oasis-open.org/join/

