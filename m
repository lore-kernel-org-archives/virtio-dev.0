Return-Path: <virtio-dev-return-12825-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FFE2C77B7A
	for <virtio-dev@archiver.kernel.org>; Fri, 26 May 2023 08:09:01 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 02E3D44348
	for <virtio-dev@archiver.kernel.org>; Fri, 26 May 2023 08:09:01 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D7255986677
	for <virtio-dev@archiver.kernel.org>; Fri, 26 May 2023 08:09:00 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id BE813983DA0; Fri, 26 May 2023 08:09:00 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AD3009863FC
	for <virtio-dev@lists.oasis-open.org>; Fri, 26 May 2023 08:09:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: mVntMd-ANo6rjGj2sbu3kw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685088537; x=1687680537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iHmkDcOr7u7Bq7Y4lFGpS8DoD5+a3ipM/U3yEBt9eDI=;
        b=l1141FeJcjF0LtH0K4Pm7og4bnOQTw5hZ+aHOQfMe4QL40vyY7jGG16rF55dhlhi1R
         8P38A4HAl4+3nBCeUg7ancapWVmhumV4kS6ijSSIq6M9MtZRVIQtruhOaXrghkAvqxwp
         HoXbiyNE1oa+uxIZfN4ySTimh77qREFYbnzSgmdKN1Wpxp3obzdAe6MjogfnM0R32qv/
         4t7Mowt60+QIZjX/xC6yB0AH+xByO5StEzZdjGg4Xm+TX/mgRXuRq9TSEeM9NTi1q6f2
         /9tTNcx3ZVFyHSI95CTyEBFJ9mIFPvmQIpxR/2VIIGc9q2GLrdPQ9j/xrkg8SlmqVk+V
         cwSQ==
X-Gm-Message-State: AC+VfDzzgCcK9Yv1y7P3U2ytDQx942QKijf7gloYx1rQc7Fv283ax+V1
	UdcBj4v9VyJAlZF6HLEP7rrxvHVaPEbbB//iDaxtlI11sq3gRuLXoFD9tVGFMCVFOP+Hj3n4v5d
	OeXxP6fUMEfL7ikdggxr7gYKJip1PX4uVrvN0sWj4BLxD
X-Received: by 2002:a81:7cc6:0:b0:565:ba06:6e36 with SMTP id x189-20020a817cc6000000b00565ba066e36mr518735ywc.33.1685088537691;
        Fri, 26 May 2023 01:08:57 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7V17vl/Pj4IY2I3wEXP690pacpdjGtrn9qS+e6ZkhCr0IYxImpGzixBASqDxuonBUK4z4ftVMM+Zo/YC2hCUQ=
X-Received: by 2002:a81:7cc6:0:b0:565:ba06:6e36 with SMTP id
 x189-20020a817cc6000000b00565ba066e36mr518710ywc.33.1685088537449; Fri, 26
 May 2023 01:08:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230522185730.3233001-1-eperezma@redhat.com> <20230522185730.3233001-2-eperezma@redhat.com>
 <20230522152226-mutt-send-email-mst@kernel.org> <CAJaqyWfSzqdyPHogzccuYBeThJgcx-A_AfF8tmqLgxKNVczBWA@mail.gmail.com>
 <1735e461-a858-5bf2-bf9f-d9418e281d0c@amd.com> <CAJaqyWd632RiE9Zhc8OLsQbnaC42VG1FW97UMDHPQRofukYPrg@mail.gmail.com>
 <CACGkMEudc7M5ZqRvhYkW35Sb6pK9yp1LObcFZLkX-sMRYwEj7w@mail.gmail.com>
 <CAJaqyWfkVdejuSaSbQ_9XWZW3BrGPfQvRZw9Cw_uJajWX3JO2w@mail.gmail.com> <CACGkMEtnY86fT1BG8D34TtX-+K45E2aBbk9rwHfF8bGbhOuM1g@mail.gmail.com>
In-Reply-To: <CACGkMEtnY86fT1BG8D34TtX-+K45E2aBbk9rwHfF8bGbhOuM1g@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 26 May 2023 10:08:21 +0200
Message-ID: <CAJaqyWeJQv3n4Jm=s-Hx4RVWeySc5zZXEnh9GU4OA+K2+QG5-g@mail.gmail.com>
To: Jason Wang <jasowang@redhat.com>
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

On Fri, May 26, 2023 at 8:26=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Thu, May 25, 2023 at 12:25=E2=80=AFAM Eugenio Perez Martin
> <eperezma@redhat.com> wrote:
> >
> > On Wed, May 24, 2023 at 6:07=E2=80=AFAM Jason Wang <jasowang@redhat.com=
> wrote:
> > >
> > > On Tue, May 23, 2023 at 1:55=E2=80=AFPM Eugenio Perez Martin
> > > <eperezma@redhat.com> wrote:
> > > >
> > > > On Mon, May 22, 2023 at 11:22=E2=80=AFPM Shannon Nelson <shannon.ne=
lson@amd.com> wrote:
> > > > >
> > > > > On 5/22/23 1:07 PM, Eugenio Perez Martin wrote:
> > > > > >
> > > > > > On Mon, May 22, 2023 at 9:23=E2=80=AFPM Michael S. Tsirkin <mst=
@redhat.com> wrote:
> > > > > >>
> > > > > >> On Mon, May 22, 2023 at 08:57:27PM +0200, Eugenio P=C3=A9rez w=
rote:
> > > > > >>> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > > > >>> ---
> > > > > >>>   include/uapi/linux/vhost_types.h | 2 ++
> > > > > >>>   1 file changed, 2 insertions(+)
> > > > > >>>
> > > > > >>> diff --git a/include/uapi/linux/vhost_types.h b/include/uapi/=
linux/vhost_types.h
> > > > > >>> index c5690a8992d8..a1b316f49b38 100644
> > > > > >>> --- a/include/uapi/linux/vhost_types.h
> > > > > >>> +++ b/include/uapi/linux/vhost_types.h
> > > > > >>> @@ -165,5 +165,7 @@ struct vhost_vdpa_iova_range {
> > > > > >>>   #define VHOST_BACKEND_F_SUSPEND  0x4
> > > > > >>>   /* Device can be resumed */
> > > > > >>>   #define VHOST_BACKEND_F_RESUME  0x5
> > > > > >>> +/* Device can enable virtqueues after DRIVER_OK */
> > > > > >>
> > > > > >> A bit more detail on what does this mean?
> > > > > >> It's normally driver that enables VQs not device itself ...
> > > > > >>
> > > > > >
> > > > > > I agree, it is not well explained.
> > > > > >
> > > > > > What about "Device supports the driver to enable virtqueues aft=
er DRIVER_OK"?
> > > > > >
> > > > > >>> +#define VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK  0x6
> > > > >
> > > > > Does this mean it is possible only after DRIVER_OK, or does it me=
an in
> > > > > addition to before DRIVER_OK?  It isn't clear to me.
> > > > >
> > > > > Maybe something like
> > > > > "Device supports virtqueue enable only after DRIVER_OK"
> > > > > or
> > > > > "Device supports virtqueue enable both before and after DRIVER_OK=
"
> > > > >
> > > >
> > > > I agree too,
> > > >
> > > > With the previous suggestion it would be:
> > > >
> > > > "Device supports the driver to enable virtqueues both before and af=
ter
> > > > DRIVER_OK"
> > >
> > > Btw, I think it might be worth clarifying whether or not this is
> > > supported by the current virtio spec. Spec seems to be unclear on
> > > this:
> > >
> > > 1) The driver MUST NOT write a 0 to queue_enable.
> > > 2) if reset is support, driver can wrote 1 to re-enable a virtqueue
> > >
> > > But it doesn't say if the driver can write 1 after DRIVER_OK without =
reset.
> > >
> >
> > To double check, you mean to write 1 even if the queue is live?
> > "without reset *the virtqueue*"?
>
> No I mean something like this
>
> 1) write queue_enable to cvq
> 2) set DRIVER_OK
> 3) restore
> 4) write queue_enable to txq 0
>
> >
> > I'd add another combination that might be worth clarifying: ack
> > VIRTIO_F_RING_RESET, write 1 to queue_enable, then write 1 to
> > queue_reset. Set state DRIVER_OK, and then enable the queue
> > afterwards. Is this valid?
>
> Spec doesn't say it can't so it's implementation specific which is
> probably suboptimal. But as replied in another thread this seems to be
> supported by Qemu.
>

Right, as long as the queue number is valid qemu allows it at this moment.

> >
> > I guess it is not, but I don't see the standard forbidding it, isn't it=
?
>
> Yes, this needs to be fixed.
>
> But one point here is that we should make svq work without RING_RESET
> (or we can say if RING_REST implies the feature you proposed here)
>

If RING_RESET implies that the driver can enable just CVQ and that it
can enable data vqs after DRIVER_OK and is easy to implement for hw
vendors, I think it is easier to reuse it, instead of creating a new
feature bit that overlaps so much with it.

Thanks!


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

