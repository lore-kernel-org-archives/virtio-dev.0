Return-Path: <virtio-dev-return-12798-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EE7CC77B7C
	for <virtio-dev@archiver.kernel.org>; Wed, 24 May 2023 04:07:04 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 9029542836
	for <virtio-dev@archiver.kernel.org>; Wed, 24 May 2023 04:07:03 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 79527986413
	for <virtio-dev@archiver.kernel.org>; Wed, 24 May 2023 04:07:03 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 59EC698628B; Wed, 24 May 2023 04:07:03 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 414649863FB
	for <virtio-dev@lists.oasis-open.org>; Wed, 24 May 2023 04:07:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: v_roSngUPFasqBQD_v0ekA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684901219; x=1687493219;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2n9cpD8iEq/qOCvWeXAElpznbSiEZbJ3AJNRRdfUgAM=;
        b=UCIreGk6o4L9fLVlJDZEcVD3RTQj4ql93h5n95QQajbUVS4NwW+EQFjLZEZYHQ50co
         VguMODWfAAkmsUGlkTMDFQ1yUhjPNRCBPZzwH8vYlRtLcLtJ7ar/Udpqh7emEDiXebey
         Cwl91sG62vHpLSVA7tV5v5kYRDO5qwir4KX5lMxRU/R0YJDqaS7W4MRP1NZTuuuX/U0V
         t9jtgyKZEBT9MDglGw5t1Hn4zYGHMVxF6fPGKrVAmadP3crusnHx3CiCZZ9Pv2KZDXzR
         2W/51UIzQ5xY4adgXiUEEr6+611saCXej3XArSB+6pbS+IVGuVb5f/L+h13Z8ksKFBIF
         Nytw==
X-Gm-Message-State: AC+VfDwLm0pro9MWnNAHrpxNlErYRcd79PupobjQ8fW3WX9r3xXfUD2b
	juIMpAJGEs5lpdE2YXkKorB0lw8JSjJ1F/wsYQWS4yBeH0z1rUKRIQAZOjqTO2SQlJASnHRWdg8
	wl+O+W1gm80Sb2RrSM70CYqs0soPSdPm0zXLrCGWh+7Ys
X-Received: by 2002:ac2:5a07:0:b0:4f3:9001:848d with SMTP id q7-20020ac25a07000000b004f39001848dmr4698557lfn.9.1684901218803;
        Tue, 23 May 2023 21:06:58 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5CJlBex098H59TQQ3uPV7fbIXwK3UZAsD5j+7yt/OV25Ca/sgSWs4xtkBVIsHWTCtJYjT2ZtUbzFbflTY41DI=
X-Received: by 2002:ac2:5a07:0:b0:4f3:9001:848d with SMTP id
 q7-20020ac25a07000000b004f39001848dmr4698539lfn.9.1684901218506; Tue, 23 May
 2023 21:06:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230522185730.3233001-1-eperezma@redhat.com> <20230522185730.3233001-2-eperezma@redhat.com>
 <20230522152226-mutt-send-email-mst@kernel.org> <CAJaqyWfSzqdyPHogzccuYBeThJgcx-A_AfF8tmqLgxKNVczBWA@mail.gmail.com>
 <1735e461-a858-5bf2-bf9f-d9418e281d0c@amd.com> <CAJaqyWd632RiE9Zhc8OLsQbnaC42VG1FW97UMDHPQRofukYPrg@mail.gmail.com>
In-Reply-To: <CAJaqyWd632RiE9Zhc8OLsQbnaC42VG1FW97UMDHPQRofukYPrg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 24 May 2023 12:06:47 +0800
Message-ID: <CACGkMEudc7M5ZqRvhYkW35Sb6pK9yp1LObcFZLkX-sMRYwEj7w@mail.gmail.com>
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

On Tue, May 23, 2023 at 1:55=E2=80=AFPM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Mon, May 22, 2023 at 11:22=E2=80=AFPM Shannon Nelson <shannon.nelson@a=
md.com> wrote:
> >
> > On 5/22/23 1:07 PM, Eugenio Perez Martin wrote:
> > >
> > > On Mon, May 22, 2023 at 9:23=E2=80=AFPM Michael S. Tsirkin <mst@redha=
t.com> wrote:
> > >>
> > >> On Mon, May 22, 2023 at 08:57:27PM +0200, Eugenio P=C3=A9rez wrote:
> > >>> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > >>> ---
> > >>>   include/uapi/linux/vhost_types.h | 2 ++
> > >>>   1 file changed, 2 insertions(+)
> > >>>
> > >>> diff --git a/include/uapi/linux/vhost_types.h b/include/uapi/linux/=
vhost_types.h
> > >>> index c5690a8992d8..a1b316f49b38 100644
> > >>> --- a/include/uapi/linux/vhost_types.h
> > >>> +++ b/include/uapi/linux/vhost_types.h
> > >>> @@ -165,5 +165,7 @@ struct vhost_vdpa_iova_range {
> > >>>   #define VHOST_BACKEND_F_SUSPEND  0x4
> > >>>   /* Device can be resumed */
> > >>>   #define VHOST_BACKEND_F_RESUME  0x5
> > >>> +/* Device can enable virtqueues after DRIVER_OK */
> > >>
> > >> A bit more detail on what does this mean?
> > >> It's normally driver that enables VQs not device itself ...
> > >>
> > >
> > > I agree, it is not well explained.
> > >
> > > What about "Device supports the driver to enable virtqueues after DRI=
VER_OK"?
> > >
> > >>> +#define VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK  0x6
> >
> > Does this mean it is possible only after DRIVER_OK, or does it mean in
> > addition to before DRIVER_OK?  It isn't clear to me.
> >
> > Maybe something like
> > "Device supports virtqueue enable only after DRIVER_OK"
> > or
> > "Device supports virtqueue enable both before and after DRIVER_OK"
> >
>
> I agree too,
>
> With the previous suggestion it would be:
>
> "Device supports the driver to enable virtqueues both before and after
> DRIVER_OK"

Btw, I think it might be worth clarifying whether or not this is
supported by the current virtio spec. Spec seems to be unclear on
this:

1) The driver MUST NOT write a 0 to queue_enable.
2) if reset is support, driver can wrote 1 to re-enable a virtqueue

But it doesn't say if the driver can write 1 after DRIVER_OK without reset.

Thanks


>
> Does it look better?
>
> Thanks!
>
> > sln
> >
> >
> > >>>
> > >>>   #endif
> > >>> --
> > >>> 2.31.1
> > >>
> > >
> >
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

