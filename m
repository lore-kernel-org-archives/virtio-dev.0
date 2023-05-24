Return-Path: <virtio-dev-return-12813-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F20FC77B7C
	for <virtio-dev@archiver.kernel.org>; Wed, 24 May 2023 16:25:56 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 8CDD042568
	for <virtio-dev@archiver.kernel.org>; Wed, 24 May 2023 16:25:55 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 62E339864A7
	for <virtio-dev@archiver.kernel.org>; Wed, 24 May 2023 16:25:55 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 487B7986474; Wed, 24 May 2023 16:25:55 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 35F94986484
	for <virtio-dev@lists.oasis-open.org>; Wed, 24 May 2023 16:25:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: F1CMMtHlPL-u1ye3XbyZDA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684945552; x=1687537552;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lm7rbGpm2lGZY/Oj01MmcTLACaOl8QiBSFpNOxFtWKI=;
        b=FPgR7TbfMZtY6SiU17N7m6Z0QW5M9uuTmgIc4fsXR2M6/UWT1E7ER9EJZ7m2LtYoR5
         YC2LoksN3HrYbj2GIMXeP2h4oHr28q5+w9DGgbGuOn1HObGD476+a7QLJ5r82OzLJe9u
         TDVZUZaco4/JrbDSDcbbjJQmZWFJd434LIwE71LuENQpGWwm/2/fpAOVqX0i354mI1Ed
         qu1M/diwwBOkwn8MzijS8jF6p07L19MuoPcm8AW39M+qJi3BAVWfRBinfqi2YWY5SEvj
         Fbt79/XPTs5lLUNBQ44HPGeVhEtJ/2AwuIbk3hKRwgsiAf6ai4p/lI4Wl/jBLGa7Ydth
         mMDg==
X-Gm-Message-State: AC+VfDyl0RJu3399gjXLkMKHanLCTon7RHYL5WmRmMYedVi/36Aq6bj0
	CrPewvrUjpnyAxF3EmOtyKrP3TvEFkEbMi9V1jP/NA5snF6+knnIYV/YaE84lyeE2GIJxSCC8Oy
	tA3V1LIkXX5uKV9N/qmaZ9x1QayQPF35uEFiaYi3r3UTM
X-Received: by 2002:a25:ade3:0:b0:bac:bb2f:67f2 with SMTP id d35-20020a25ade3000000b00bacbb2f67f2mr494718ybe.27.1684945552275;
        Wed, 24 May 2023 09:25:52 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5ZXNyIchlx1wPe6EPM7579EiZ9XsI1fMTYWZiWOabKzu8X0tyvrG4VOR/37znvi475Id2uZM0YXkZkt+zPlMk=
X-Received: by 2002:a25:ade3:0:b0:bac:bb2f:67f2 with SMTP id
 d35-20020a25ade3000000b00bacbb2f67f2mr494691ybe.27.1684945552030; Wed, 24 May
 2023 09:25:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230522185730.3233001-1-eperezma@redhat.com> <20230522185730.3233001-2-eperezma@redhat.com>
 <20230522152226-mutt-send-email-mst@kernel.org> <CAJaqyWfSzqdyPHogzccuYBeThJgcx-A_AfF8tmqLgxKNVczBWA@mail.gmail.com>
 <1735e461-a858-5bf2-bf9f-d9418e281d0c@amd.com> <CAJaqyWd632RiE9Zhc8OLsQbnaC42VG1FW97UMDHPQRofukYPrg@mail.gmail.com>
 <CACGkMEudc7M5ZqRvhYkW35Sb6pK9yp1LObcFZLkX-sMRYwEj7w@mail.gmail.com>
In-Reply-To: <CACGkMEudc7M5ZqRvhYkW35Sb6pK9yp1LObcFZLkX-sMRYwEj7w@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 24 May 2023 18:25:15 +0200
Message-ID: <CAJaqyWfkVdejuSaSbQ_9XWZW3BrGPfQvRZw9Cw_uJajWX3JO2w@mail.gmail.com>
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

On Wed, May 24, 2023 at 6:07=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Tue, May 23, 2023 at 1:55=E2=80=AFPM Eugenio Perez Martin
> <eperezma@redhat.com> wrote:
> >
> > On Mon, May 22, 2023 at 11:22=E2=80=AFPM Shannon Nelson <shannon.nelson=
@amd.com> wrote:
> > >
> > > On 5/22/23 1:07 PM, Eugenio Perez Martin wrote:
> > > >
> > > > On Mon, May 22, 2023 at 9:23=E2=80=AFPM Michael S. Tsirkin <mst@red=
hat.com> wrote:
> > > >>
> > > >> On Mon, May 22, 2023 at 08:57:27PM +0200, Eugenio P=C3=A9rez wrote=
:
> > > >>> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > >>> ---
> > > >>>   include/uapi/linux/vhost_types.h | 2 ++
> > > >>>   1 file changed, 2 insertions(+)
> > > >>>
> > > >>> diff --git a/include/uapi/linux/vhost_types.h b/include/uapi/linu=
x/vhost_types.h
> > > >>> index c5690a8992d8..a1b316f49b38 100644
> > > >>> --- a/include/uapi/linux/vhost_types.h
> > > >>> +++ b/include/uapi/linux/vhost_types.h
> > > >>> @@ -165,5 +165,7 @@ struct vhost_vdpa_iova_range {
> > > >>>   #define VHOST_BACKEND_F_SUSPEND  0x4
> > > >>>   /* Device can be resumed */
> > > >>>   #define VHOST_BACKEND_F_RESUME  0x5
> > > >>> +/* Device can enable virtqueues after DRIVER_OK */
> > > >>
> > > >> A bit more detail on what does this mean?
> > > >> It's normally driver that enables VQs not device itself ...
> > > >>
> > > >
> > > > I agree, it is not well explained.
> > > >
> > > > What about "Device supports the driver to enable virtqueues after D=
RIVER_OK"?
> > > >
> > > >>> +#define VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK  0x6
> > >
> > > Does this mean it is possible only after DRIVER_OK, or does it mean i=
n
> > > addition to before DRIVER_OK?  It isn't clear to me.
> > >
> > > Maybe something like
> > > "Device supports virtqueue enable only after DRIVER_OK"
> > > or
> > > "Device supports virtqueue enable both before and after DRIVER_OK"
> > >
> >
> > I agree too,
> >
> > With the previous suggestion it would be:
> >
> > "Device supports the driver to enable virtqueues both before and after
> > DRIVER_OK"
>
> Btw, I think it might be worth clarifying whether or not this is
> supported by the current virtio spec. Spec seems to be unclear on
> this:
>
> 1) The driver MUST NOT write a 0 to queue_enable.
> 2) if reset is support, driver can wrote 1 to re-enable a virtqueue
>
> But it doesn't say if the driver can write 1 after DRIVER_OK without rese=
t.
>

To double check, you mean to write 1 even if the queue is live?
"without reset *the virtqueue*"?

I'd add another combination that might be worth clarifying: ack
VIRTIO_F_RING_RESET, write 1 to queue_enable, then write 1 to
queue_reset. Set state DRIVER_OK, and then enable the queue
afterwards. Is this valid?

I guess it is not, but I don't see the standard forbidding it, isn't it?

Thanks!

> Thanks
>
>
> >
> > Does it look better?
> >
> > Thanks!
> >
> > > sln
> > >
> > >
> > > >>>
> > > >>>   #endif
> > > >>> --
> > > >>> 2.31.1
> > > >>
> > > >
> > >
> >
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

