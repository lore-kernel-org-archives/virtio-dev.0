Return-Path: <virtio-dev-return-12809-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA5CBC7EE2C
	for <virtio-dev@archiver.kernel.org>; Wed, 24 May 2023 10:10:58 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 539BB17914A
	for <virtio-dev@archiver.kernel.org>; Wed, 24 May 2023 10:10:58 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 30ECA986426
	for <virtio-dev@archiver.kernel.org>; Wed, 24 May 2023 10:10:58 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 1A605986410; Wed, 24 May 2023 10:10:58 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 089E6986412
	for <virtio-dev@lists.oasis-open.org>; Wed, 24 May 2023 10:10:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: xADYGVWLPAyikljrB7Zq6g-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684923054; x=1687515054;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mFZ0hGwhq/VP4FxG26O+W0igdjv/HAM6uSPao3HxEtI=;
        b=K/YUJDGbMLpDdH3HEn6J/09cnP0GoszrXg3zdqwxzng3/c6GkthA9A9CpJ6fzkmF6+
         FnjTogFg3Qhu79kxaiO0efgY/4t1JlKw00S8joyeni8Ihts/uBuQyImgMpAEuPVaeqkE
         bBBsJu6V4Uo05t2j/M2dMOO6ytFGVgtUY5FGJvc0y+FQ30h5wYsIt2uNMKBMr9rYZe9i
         /4sWgzVPXivFWMXM85UZZZWxWIMfE09hhLp0mJNbuB0DJPZDK5PZWtP4J+mQcNjdnxM8
         uhwqLzceW9Y2iK9mtRA9dk2BdcqX2nyeyzU+oa6F6+AljvVWD2CCr6gq6ZKCOnAyVlh9
         pMlA==
X-Gm-Message-State: AC+VfDzTMQQ/1filMqZ+7r7PWfiRYwwO0IkDebPs+jZWB1Py/jlSqPtw
	eYNU1RaDtcEyPHyLBx4kq1dva6EgNS6iDROnUcrtFAQ0Yv9mm6a068bdofyXWMUlEDJE/iruSwc
	YcQFFqp+q6QMGbwsVjoCoQa1pHDCQ
X-Received: by 2002:a5d:4d02:0:b0:309:4dd0:c0a8 with SMTP id z2-20020a5d4d02000000b003094dd0c0a8mr15160142wrt.7.1684923054229;
        Wed, 24 May 2023 03:10:54 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4ciZkf9B93O2vRocQPqCJTCbuzKB9goczOHZOKwXmSxwOqu52ne794etM06uVLr9tCjb6OAg==
X-Received: by 2002:a5d:4d02:0:b0:309:4dd0:c0a8 with SMTP id z2-20020a5d4d02000000b003094dd0c0a8mr15160109wrt.7.1684923053875;
        Wed, 24 May 2023 03:10:53 -0700 (PDT)
Date: Wed, 24 May 2023 06:10:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Eugenio Perez Martin <eperezma@redhat.com>,
	Shannon Nelson <shannon.nelson@amd.com>, si-wei.liu@oracle.com,
	longpeng2@huawei.com, Lei Yang <leiyang@redhat.com>,
	Laurent Vivier <lvivier@redhat.com>, alvaro.karsz@solid-run.com,
	Gautam Dawar <gdawar@xilinx.com>, Cindy Lu <lulu@redhat.com>,
	Zhu Lingshan <lingshan.zhu@intel.com>,
	Liuxiangdong <liuxiangdong5@huawei.com>,
	Parav Pandit <parav@mellanox.com>,
	Harpreet Singh Anand <hanand@xilinx.com>,
	"Gonglei (Arei)" <arei.gonglei@huawei.com>,
	Shannon Nelson <snelson@pensando.io>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Virtio-Dev <virtio-dev@lists.oasis-open.org>
Message-ID: <20230524060842-mutt-send-email-mst@kernel.org>
References: <20230522185730.3233001-1-eperezma@redhat.com>
 <20230522185730.3233001-2-eperezma@redhat.com>
 <20230522152226-mutt-send-email-mst@kernel.org>
 <CAJaqyWfSzqdyPHogzccuYBeThJgcx-A_AfF8tmqLgxKNVczBWA@mail.gmail.com>
 <1735e461-a858-5bf2-bf9f-d9418e281d0c@amd.com>
 <CAJaqyWd632RiE9Zhc8OLsQbnaC42VG1FW97UMDHPQRofukYPrg@mail.gmail.com>
 <CACGkMEudc7M5ZqRvhYkW35Sb6pK9yp1LObcFZLkX-sMRYwEj7w@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEudc7M5ZqRvhYkW35Sb6pK9yp1LObcFZLkX-sMRYwEj7w@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [RFC 1/4] vdpa: add VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK flag

On Wed, May 24, 2023 at 12:06:47PM +0800, Jason Wang wrote:
> On Tue, May 23, 2023 at 1:55 PM Eugenio Perez Martin
> <eperezma@redhat.com> wrote:
> >
> > On Mon, May 22, 2023 at 11:22 PM Shannon Nelson <shannon.nelson@amd.com> wrote:
> > >
> > > On 5/22/23 1:07 PM, Eugenio Perez Martin wrote:
> > > >
> > > > On Mon, May 22, 2023 at 9:23 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >>
> > > >> On Mon, May 22, 2023 at 08:57:27PM +0200, Eugenio Pérez wrote:
> > > >>> Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
> > > >>> ---
> > > >>>   include/uapi/linux/vhost_types.h | 2 ++
> > > >>>   1 file changed, 2 insertions(+)
> > > >>>
> > > >>> diff --git a/include/uapi/linux/vhost_types.h b/include/uapi/linux/vhost_types.h
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
> > > > What about "Device supports the driver to enable virtqueues after DRIVER_OK"?
> > > >
> > > >>> +#define VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK  0x6
> > >
> > > Does this mean it is possible only after DRIVER_OK, or does it mean in
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
> But it doesn't say if the driver can write 1 after DRIVER_OK without reset.
> 
> Thanks

I don't think it can. Do any drivers do this?


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


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

