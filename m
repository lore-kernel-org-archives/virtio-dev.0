Return-Path: <virtio-dev-return-12821-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56476C77B7A
	for <virtio-dev@archiver.kernel.org>; Fri, 26 May 2023 06:21:24 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 70F80FD56D
	for <virtio-dev@archiver.kernel.org>; Fri, 26 May 2023 06:21:23 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 40CFF98670F
	for <virtio-dev@archiver.kernel.org>; Fri, 26 May 2023 06:21:23 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 1E284983DA0; Fri, 26 May 2023 06:21:23 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 09C549863FC
	for <virtio-dev@lists.oasis-open.org>; Fri, 26 May 2023 06:21:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: mKruJ9h-MLGtGOPlsniWog-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685082077; x=1687674077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qkbQ+gAaNNQECsRBF/zr+eKbk0W1q60keGhXYPHmYbs=;
        b=ChtBdRGQ34Bza2Lb80MrWiYAgtG3DAnNXqGPzX//rPox8Eh6FWeDxcEorNCZRvsv4B
         kWE6wA65IyFTU8qQYAjbjQ5CrHV9jUe35j60+7TIqPDynAGyGHqSqFR+Vs6w5Yzcjt29
         YiZXSIpoMj66LIc7s1ni88ZY03Z47OWGxVyimkUXylmlPnPggZMWKDc2tsIoQveA+Mg3
         2XT47V/P1wOa1zJwVUtotmHzIM7pcR5ckmYe8DNBcld9p4Ecez2ooWU+rwuOc2OtR6JW
         8AbynN4QXXLe3mVuwkscWiqcXKRsVOYb1p37h6Z2jJNzYhrM70Am0Y+YNBbo9Iznnj8/
         nmmg==
X-Gm-Message-State: AC+VfDyK37tFeQZ0Wb4Mk1eUe004e87AVrlCYbMLDULrR/213h74AvMh
	5zN3RIPAVjhznRqUZkxX4XZSJrIrzQqSVqMyI8anb4mFO1pFaIIYAcI+AN43wqDUkMTP7nHYNNP
	JXE4JCPqMyLO6zcdeoaqG64uhZnaiXmL20rfBGK7xHCFk
X-Received: by 2002:a2e:95d1:0:b0:2af:2441:f709 with SMTP id y17-20020a2e95d1000000b002af2441f709mr309508ljh.29.1685082077125;
        Thu, 25 May 2023 23:21:17 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6JTg9F6fo2V7yrRZVsJyhDjmEaoxl8euDSK3yhuEPhWFSAd+cScoRYD+w5A1tkLvgghCYlpqitfZ/pRLxDF+k=
X-Received: by 2002:a2e:95d1:0:b0:2af:2441:f709 with SMTP id
 y17-20020a2e95d1000000b002af2441f709mr309501ljh.29.1685082076830; Thu, 25 May
 2023 23:21:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230522185730.3233001-1-eperezma@redhat.com> <20230522185730.3233001-2-eperezma@redhat.com>
 <20230522152226-mutt-send-email-mst@kernel.org> <CAJaqyWfSzqdyPHogzccuYBeThJgcx-A_AfF8tmqLgxKNVczBWA@mail.gmail.com>
 <1735e461-a858-5bf2-bf9f-d9418e281d0c@amd.com> <CAJaqyWd632RiE9Zhc8OLsQbnaC42VG1FW97UMDHPQRofukYPrg@mail.gmail.com>
 <CACGkMEudc7M5ZqRvhYkW35Sb6pK9yp1LObcFZLkX-sMRYwEj7w@mail.gmail.com> <20230524060842-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230524060842-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 26 May 2023 14:21:05 +0800
Message-ID: <CACGkMEtamLokdst8+fBY48LtQrZZ4V-qVM=ocYi1do1H-VYXmw@mail.gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Eugenio Perez Martin <eperezma@redhat.com>, Shannon Nelson <shannon.nelson@amd.com>, si-wei.liu@oracle.com, 
	longpeng2@huawei.com, Lei Yang <leiyang@redhat.com>, 
	Laurent Vivier <lvivier@redhat.com>, alvaro.karsz@solid-run.com, 
	Gautam Dawar <gdawar@xilinx.com>, Cindy Lu <lulu@redhat.com>, 
	Zhu Lingshan <lingshan.zhu@intel.com>, Liuxiangdong <liuxiangdong5@huawei.com>, 
	Parav Pandit <parav@mellanox.com>, Harpreet Singh Anand <hanand@xilinx.com>, 
	"Gonglei (Arei)" <arei.gonglei@huawei.com>, Shannon Nelson <snelson@pensando.io>, 
	Stefano Garzarella <sgarzare@redhat.com>, Dragos Tatulea <dtatulea@nvidia.com>, 
	Virtio-Dev <virtio-dev@lists.oasis-open.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] Re: [RFC 1/4] vdpa: add VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK flag

On Wed, May 24, 2023 at 6:10=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Wed, May 24, 2023 at 12:06:47PM +0800, Jason Wang wrote:
> > On Tue, May 23, 2023 at 1:55=E2=80=AFPM Eugenio Perez Martin
> > <eperezma@redhat.com> wrote:
> > >
> > > On Mon, May 22, 2023 at 11:22=E2=80=AFPM Shannon Nelson <shannon.nels=
on@amd.com> wrote:
> > > >
> > > > On 5/22/23 1:07 PM, Eugenio Perez Martin wrote:
> > > > >
> > > > > On Mon, May 22, 2023 at 9:23=E2=80=AFPM Michael S. Tsirkin <mst@r=
edhat.com> wrote:
> > > > >>
> > > > >> On Mon, May 22, 2023 at 08:57:27PM +0200, Eugenio P=C3=A9rez wro=
te:
> > > > >>> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > > >>> ---
> > > > >>>   include/uapi/linux/vhost_types.h | 2 ++
> > > > >>>   1 file changed, 2 insertions(+)
> > > > >>>
> > > > >>> diff --git a/include/uapi/linux/vhost_types.h b/include/uapi/li=
nux/vhost_types.h
> > > > >>> index c5690a8992d8..a1b316f49b38 100644
> > > > >>> --- a/include/uapi/linux/vhost_types.h
> > > > >>> +++ b/include/uapi/linux/vhost_types.h
> > > > >>> @@ -165,5 +165,7 @@ struct vhost_vdpa_iova_range {
> > > > >>>   #define VHOST_BACKEND_F_SUSPEND  0x4
> > > > >>>   /* Device can be resumed */
> > > > >>>   #define VHOST_BACKEND_F_RESUME  0x5
> > > > >>> +/* Device can enable virtqueues after DRIVER_OK */
> > > > >>
> > > > >> A bit more detail on what does this mean?
> > > > >> It's normally driver that enables VQs not device itself ...
> > > > >>
> > > > >
> > > > > I agree, it is not well explained.
> > > > >
> > > > > What about "Device supports the driver to enable virtqueues after=
 DRIVER_OK"?
> > > > >
> > > > >>> +#define VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK  0x6
> > > >
> > > > Does this mean it is possible only after DRIVER_OK, or does it mean=
 in
> > > > addition to before DRIVER_OK?  It isn't clear to me.
> > > >
> > > > Maybe something like
> > > > "Device supports virtqueue enable only after DRIVER_OK"
> > > > or
> > > > "Device supports virtqueue enable both before and after DRIVER_OK"
> > > >
> > >
> > > I agree too,
> > >
> > > With the previous suggestion it would be:
> > >
> > > "Device supports the driver to enable virtqueues both before and afte=
r
> > > DRIVER_OK"
> >
> > Btw, I think it might be worth clarifying whether or not this is
> > supported by the current virtio spec. Spec seems to be unclear on
> > this:
> >
> > 1) The driver MUST NOT write a 0 to queue_enable.
> > 2) if reset is support, driver can wrote 1 to re-enable a virtqueue
> >
> > But it doesn't say if the driver can write 1 after DRIVER_OK without re=
set.
> >
> > Thanks
>
> I don't think it can. Do any drivers do this?

I don't know. But the spec is unclear in this. And Qemu seems to
support this which is probably a side effect since vq reset.

    case VIRTIO_PCI_COMMON_Q_ENABLE:
        if (val =3D=3D 1) {
            virtio_queue_set_num(vdev, vdev->queue_sel,
                                 proxy->vqs[vdev->queue_sel].num);
            virtio_queue_set_rings(vdev, vdev->queue_sel,
                       ((uint64_t)proxy->vqs[vdev->queue_sel].desc[1]) << 3=
2 |
                       proxy->vqs[vdev->queue_sel].desc[0],
                       ((uint64_t)proxy->vqs[vdev->queue_sel].avail[1]) << =
32 |
                       proxy->vqs[vdev->queue_sel].avail[0],
                       ((uint64_t)proxy->vqs[vdev->queue_sel].used[1]) << 3=
2 |
                       proxy->vqs[vdev->queue_sel].used[0]);
            proxy->vqs[vdev->queue_sel].enabled =3D 1;
            proxy->vqs[vdev->queue_sel].reset =3D 0;
            virtio_queue_enable(vdev, vdev->queue_sel);

We need either

1) relax the spec to allow this feature
2) or fix the qemu (not sure if it's too late to do this) and have a
new feature for queue_enable after DRIVER_OK

Thanks

>
>
> >
> > >
> > > Does it look better?
> > >
> > > Thanks!
> > >
> > > > sln
> > > >
> > > >
> > > > >>>
> > > > >>>   #endif
> > > > >>> --
> > > > >>> 2.31.1
> > > > >>
> > > > >
> > > >
> > >
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

