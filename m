Return-Path: <virtio-dev-return-12822-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B52A0C7EE2C
	for <virtio-dev@archiver.kernel.org>; Fri, 26 May 2023 06:26:06 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id DA87A157EEB
	for <virtio-dev@archiver.kernel.org>; Fri, 26 May 2023 06:26:05 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A68AD986685
	for <virtio-dev@archiver.kernel.org>; Fri, 26 May 2023 06:26:05 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 8EEDB983DA0; Fri, 26 May 2023 06:26:05 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7A1319863FC
	for <virtio-dev@lists.oasis-open.org>; Fri, 26 May 2023 06:26:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 3FHqy_sDOfiVhkg9WBbLFg-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685082361; x=1687674361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y07JPpDe5BzlcM88WYUG8y3MpAbmJl4ebZL7H/lUKoU=;
        b=b4Ulch20OJnBcCPi/vWBtmP7ItHPNjFO2vyKRvhuG8Y3JGesFND42MBfdolNm4vQUH
         q0Iulyz2h0//e19ljVYeZbqQUKwX7+MMTHoEHwzMUA8FH2ZQZiXTAP6ruIvUCePXjt2c
         tOhi8c3lTh/jTV62VoqB0EREbPgfme5voOEj2v3D+W/1+P9LyIGTy4IlO0n6736dSxrb
         IWHpP8BLYSTW1s0bhz6skamNoFSGglbPOEGXxZb7UV51l+ISOJtIG4i3omodgnXrSp8a
         sUr2vU4oYJzVXcD1+Y5SNXYaypcR4Q35hmGliIPla0JL72Z8B+6XNyYGfjm3upylDRt+
         K+pg==
X-Gm-Message-State: AC+VfDy7ObUv9EemORMtkv2DyozSnv8EqZ5PtIuoUk85X+tCpq34l1vc
	U2AlzZau2YvEexICgAB14ikoUlc1ETiKiY21Pqod90pDpkA5OOhv1g39HII89vxPB1xIPRagWSw
	ChWWXc0iY8t+yQ+i2VEhVi16ndFtPXUQj7CZUSwTdGG7w
X-Received: by 2002:a2e:9d03:0:b0:2a9:f584:659a with SMTP id t3-20020a2e9d03000000b002a9f584659amr298369lji.23.1685082361394;
        Thu, 25 May 2023 23:26:01 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4yvNoHYi2ts/NwyNKNYBOeFcuYqPSR5e1ZwTCLjoXeNpA+KAt9Zs54/ieeJcj3XzlEoIBoE+6/jE1Ggxc1hYc=
X-Received: by 2002:a2e:9d03:0:b0:2a9:f584:659a with SMTP id
 t3-20020a2e9d03000000b002a9f584659amr298357lji.23.1685082361117; Thu, 25 May
 2023 23:26:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230522185730.3233001-1-eperezma@redhat.com> <20230522185730.3233001-2-eperezma@redhat.com>
 <20230522152226-mutt-send-email-mst@kernel.org> <CAJaqyWfSzqdyPHogzccuYBeThJgcx-A_AfF8tmqLgxKNVczBWA@mail.gmail.com>
 <1735e461-a858-5bf2-bf9f-d9418e281d0c@amd.com> <CAJaqyWd632RiE9Zhc8OLsQbnaC42VG1FW97UMDHPQRofukYPrg@mail.gmail.com>
 <CACGkMEudc7M5ZqRvhYkW35Sb6pK9yp1LObcFZLkX-sMRYwEj7w@mail.gmail.com> <CAJaqyWfkVdejuSaSbQ_9XWZW3BrGPfQvRZw9Cw_uJajWX3JO2w@mail.gmail.com>
In-Reply-To: <CAJaqyWfkVdejuSaSbQ_9XWZW3BrGPfQvRZw9Cw_uJajWX3JO2w@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 26 May 2023 14:25:50 +0800
Message-ID: <CACGkMEtnY86fT1BG8D34TtX-+K45E2aBbk9rwHfF8bGbhOuM1g@mail.gmail.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Shannon Nelson <shannon.nelson@amd.com>, "Michael S. Tsirkin" <mst@redhat.com>, si-wei.liu@oracle.com, 
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

On Thu, May 25, 2023 at 12:25=E2=80=AFAM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Wed, May 24, 2023 at 6:07=E2=80=AFAM Jason Wang <jasowang@redhat.com> =
wrote:
> >
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
>
> To double check, you mean to write 1 even if the queue is live?
> "without reset *the virtqueue*"?

No I mean something like this

1) write queue_enable to cvq
2) set DRIVER_OK
3) restore
4) write queue_enable to txq 0

>
> I'd add another combination that might be worth clarifying: ack
> VIRTIO_F_RING_RESET, write 1 to queue_enable, then write 1 to
> queue_reset. Set state DRIVER_OK, and then enable the queue
> afterwards. Is this valid?

Spec doesn't say it can't so it's implementation specific which is
probably suboptimal. But as replied in another thread this seems to be
supported by Qemu.

>
> I guess it is not, but I don't see the standard forbidding it, isn't it?

Yes, this needs to be fixed.

But one point here is that we should make svq work without RING_RESET
(or we can say if RING_REST implies the feature you proposed here)

Thanks

>
> Thanks!
>
> > Thanks
> >
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
> >
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

