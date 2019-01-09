Return-Path: virtio-dev-return-5303-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 84FBD985CF2
	for <virtio-dev@lists.oasis-open.org>; Wed,  9 Jan 2019 14:52:20 +0000 (UTC)
Date: Wed, 9 Jan 2019 09:52:07 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190109095048-mutt-send-email-mst@kernel.org>
References: <1546844466-38079-1-git-send-email-wei.w.wang@intel.com>
 <1546844466-38079-2-git-send-email-wei.w.wang@intel.com>
 <4ea022d4-6b89-b481-5747-871e154dd21a@de.ibm.com>
 <5C343688.2060609@intel.com>
 <20f5fb20-612a-fe37-c5e1-af5ecb98f5d3@de.ibm.com>
 <5C35CE55.6030200@intel.com>
 <8f0977ee-1cc1-56da-f4a6-641b8887648a@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <8f0977ee-1cc1-56da-f4a6-641b8887648a@de.ibm.com>
Subject: [virtio-dev] Re: [PATCH v3 1/3] virtio-balloon: tweak config_changed
 implementation
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Wei Wang <wei.w.wang@intel.com>, virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, cohuck@redhat.com, pbonzini@redhat.com, dgilbert@redhat.com, pasic@linux.ibm.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Jan 09, 2019 at 01:07:16PM +0100, Christian Borntraeger wrote:
> On 09.01.2019 11:35, Wei Wang wrote:
> > On 01/08/2019 04:46 PM, Christian Borntraeger wrote:
> >>
> >> On 08.01.2019 06:35, Wei Wang wrote:
> >>> On 01/07/2019 09:49 PM, Christian Borntraeger wrote:
> >>>> On 07.01.2019 08:01, Wei Wang wrote:
> >>>>> virtio-ccw has deadlock issues with reading the config space inside=
 the
> >>>>> interrupt context, so we tweak the virtballoon_changed implementati=
on
> >>>>> by moving the config read operations into the related workqueue con=
texts.
> >>>>> The config_read_bitmap is used as a flag to the workqueue callbacks
> >>>>> about the related config fields that need to be read.
> >>>>>
> >>>>> The cmd_id_received is also renamed to cmd_id_received_cache, and
> >>>>> the value should be obtained via virtio_balloon_cmd_id_received.
> >>>>>
> >>>>> Reported-by: Christian Borntraeger <borntraeger@de.ibm.com>
> >>>>> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> >>>>> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> >>>>> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
> >>>> Together with
> >>>> =A0=A0=A0 virtio_pci: use queue idx instead of array idx to set up t=
he vq
> >>>> =A0=A0=A0 virtio: don't allocate vqs when names[i] =3D NULL
> >>>>
> >>>> Tested-by: Christian Borntraeger <borntraeger@de.ibm.com>
> >>> OK. I don't plan to send a new version of the above patches as no cha=
nges needed so far.
> >>>
> >>> Michael, if the above two patches look good to you, please help add t=
he related tested-by
> >>> and reviewed-by tags. Thanks.
> >> Can we also make sure that
> >>
> >> virtio_pci: use queue idx instead of array idx to set up the vq
> >> virtio: don't allocate vqs when names[i] =3D NULL
> >>
> >> also land in stable?
> >>
> >=20
> > You could also send the request to stable after it gets merged to Linus=
' tree.
> > The stable review committee will decide whether to take it.
> >=20
> > Please see Option 2:
> >=20
> > https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> >=20
>=20
> Those patches are not upstream yet, Correct?
>=20
> Michael,
>=20
> can you add the stable tag before submitting? If not, can you give me a h=
eads up when doing the
> pull request so that I can ping the stable folks.

Can you reply to patches that you feel are needed on stable with just

Cc: stable@vger.kernel.org

in the message body?

Then it's all automatically handled by ack attaching scripts.

--=20
MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

