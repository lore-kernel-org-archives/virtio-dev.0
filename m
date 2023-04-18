Return-Path: <virtio-dev-return-12271-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B5BFC77B75
	for <virtio-dev@archiver.kernel.org>; Tue, 18 Apr 2023 06:05:31 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 7CB95419B8
	for <virtio-dev@archiver.kernel.org>; Tue, 18 Apr 2023 06:05:29 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 112859866C4
	for <virtio-dev@archiver.kernel.org>; Tue, 18 Apr 2023 06:05:29 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 70E649863E8; Tue, 18 Apr 2023 06:05:28 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 033079863E7
	for <virtio-dev@lists.oasis-open.org>; Tue, 18 Apr 2023 06:04:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: weRye0X0NpaT8g4OF-5lGA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681797856; x=1684389856;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yimxm6GV1dRPRroF68NTKRBvI7pzzf56D/pj/jZK0gI=;
        b=a8+/33gDX1qnT9+B03p0L05BKtbqE9IwJuwP34XNg/Gf5lxizojeHGvEGsveURFdcH
         0DE4A5ZwpyTDCt2s9PxrkLGo67HGjD1Aryt5uxgqIXajNI+h7PaD9AX/DTqZghgyTUSO
         hTNRasqW2CrhxxPCu32L9JxmfGP1rKjadSqk/LonSWLZtgrUWHwdmiPd+elqX4oQi6J/
         1WRqEsXyzyWJgDgrkpeXtfA3R6wQF/e0UuXKAhNHi4FyqH1dbnsWw+X0CAi660uFDVBO
         y4P2wyye6Qx/62BQCD9ZEj497dH/+oT1T67fznRqLdviSMmnMCql11ttWg78eVpNvqm7
         0yuw==
X-Gm-Message-State: AAQBX9ckA7uf1oJBNIPcgLeY2JTssbjtNMa3UKeW9/eUh8WwNUyGyHnw
	Z0piNfIISIBJw/rPGXxPnDj+Vh4E+mZTbohNQcTsy8dYK9Tn/mFP5OvmBPrWFh/lfdr1lSvLB8v
	Ckze08nGixcHGWS0U2ZZaj0PgHM3h
X-Received: by 2002:a5d:43c2:0:b0:2f5:83a8:a9a9 with SMTP id v2-20020a5d43c2000000b002f583a8a9a9mr761159wrr.16.1681797855825;
        Mon, 17 Apr 2023 23:04:15 -0700 (PDT)
X-Google-Smtp-Source: AKy350aShdT6LUmneDDO3zt/q+BJxu1DeZ9shtkB1JIunlsbGJn6U5U2KER/0BOohZOip6AGhhqP0w==
X-Received: by 2002:a5d:43c2:0:b0:2f5:83a8:a9a9 with SMTP id v2-20020a5d43c2000000b002f583a8a9a9mr761144wrr.16.1681797855547;
        Mon, 17 Apr 2023 23:04:15 -0700 (PDT)
Date: Tue, 18 Apr 2023 02:04:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Halil Pasic <pasic@linux.ibm.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"sgarzare@redhat.com" <sgarzare@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Message-ID: <20230418020150-mutt-send-email-mst@kernel.org>
References: <20230411192341.751841-1-parav@nvidia.com>
 <20230411192341.751841-4-parav@nvidia.com>
 <20230417054149.5d7f62e8.pasic@linux.ibm.com>
 <PH0PR12MB548148EDDB407D4B1A3E316ADC9C9@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB548148EDDB407D4B1A3E316ADC9C9@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: Re: [virtio-dev] [PATCH v13 03/11] content: Rename confusing
 queue_notify_data and vqn names

On Mon, Apr 17, 2023 at 08:53:32PM +0000, Parav Pandit wrote:
> > > @@ -1053,9 +1059,9 @@ \subsubsection{Available Buffer
> > > Notifications}\label{sec:Virtio Transport Option  If
> > VIRTIO_F_NOTIF_CONFIG_DATA has been negotiated:
> > >  \begin{itemize}
> > >  \item If VIRTIO_F_NOTIFICATION_DATA has not been negotiated, the
> > > driver MUST use the -\field{queue_notify_data} value instead of the virtqueue
> > index.
> > > +\field{queue_notify_id} value instead of the virtqueue index.
> > >  \item If VIRTIO_F_NOTIFICATION_DATA has been negotiated, the driver
> > > MUST set the -\field{vqn} field to the \field{queue_notify_data} value.
> > > +\field{vq_notify_id} field to the \field{queue_notify_id} value.
> > 
> > Seems you did not catch these with the s/_id/_config_data/. By doing the
> > replace one would get queue_notify_config_data, vq_notify_config_data and
> > queue_notify_config_data respectively.
> > 
> > But that still does not seem right, and the right answer depends on to what do
> > we rename \field{vqn}.
> > 
> vqn -> vq_notif_config_data in the notification structure.
> 
> virtio_pci_common_cfg.queue_notify_data -> queue_notify_config_data.
> 
> Better to rename
> 
> VIRTIO_F_NOTIF_CONFIG_DATA to VIRTIO_F_NOTIFY_CONFIG_DATA.
> Adding "Y" is not going to make it that long. Field names will have some consistency.
> WDYT?

I think this NOTIF stands for "notification", not "notify".

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

