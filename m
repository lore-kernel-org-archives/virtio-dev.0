Return-Path: <virtio-dev-return-12554-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30424C7EE21
	for <virtio-dev@archiver.kernel.org>; Thu,  4 May 2023 18:50:31 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 6AB8D56D8
	for <virtio-dev@archiver.kernel.org>; Thu,  4 May 2023 18:50:29 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 02F9D98673F
	for <virtio-dev@archiver.kernel.org>; Thu,  4 May 2023 18:50:29 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 5F5729866B6; Thu,  4 May 2023 18:50:28 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BCD5C9866B4
	for <virtio-dev@lists.oasis-open.org>; Thu,  4 May 2023 18:49:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: fS0Mui3LPi-KeVrFJ8nTfw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683226191; x=1685818191;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1qrLmUU46nyV9WB8t8lkreTTP55234ud6aDqdEkXOVc=;
        b=D9pNx+CzcqcauS55frVfTMxl7T8EAY5zrD1p5pDQiQgCynr26T3lsK5jvK/8MLIVx7
         vyvcrdKr5mWEWitk9UOqOi6deWGU0/rtdFH2Afalcf+pFOPG7mQg8oaxrKl/LsOP6Bq0
         ll5uos2wzNx2ZLM44q7Wuvfq6ZcB/usHXmEV8enF8iloI+O+oj4YPGA/kBicqOTVA+bX
         53w3c9OzLm6HZW3gqj2asr7kj+XPIxsyHDr2hU4oFJ6hjcXSdSBOlqcm9GzRgFnrAVLM
         y+zgP0dJAdV0AjZHpIK4YtueAZP25I6vQ3rAqR0a1cb4uUc5pMC9kMfJwP/EJZm1VAvQ
         7Mfg==
X-Gm-Message-State: AC+VfDzuPjyMJWwKIDQGvwCjNieipnAeA7J4oa+LfIM1LX48UG+bBBC5
	gzRWn1Qmz00Ke+KrdpATvyzaev++gw5MZ8azfMLKC58/6tLZwba4/9OGff7kss1UqA+liWnU+IS
	WKswXVNjtpKdlU//hAa9gPi/svoG6
X-Received: by 2002:a1c:7201:0:b0:3f1:7972:429d with SMTP id n1-20020a1c7201000000b003f17972429dmr461294wmc.18.1683226191673;
        Thu, 04 May 2023 11:49:51 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4NIJv63T0zDgW59k4ub9dxlBS7rndeNSr620lLqcgwQc2YnFudOVr4et82kgz8kByrJo2R/g==
X-Received: by 2002:a1c:7201:0:b0:3f1:7972:429d with SMTP id n1-20020a1c7201000000b003f17972429dmr461286wmc.18.1683226191351;
        Thu, 04 May 2023 11:49:51 -0700 (PDT)
Date: Thu, 4 May 2023 14:49:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: David Edmondson <david.edmondson@oracle.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"sgarzare@redhat.com" <sgarzare@redhat.com>,
	"pasic@linux.ibm.com" <pasic@linux.ibm.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Message-ID: <20230504144914-mutt-send-email-mst@kernel.org>
References: <20230504022959.547025-1-parav@nvidia.com>
 <20230504022959.547025-4-parav@nvidia.com>
 <m21qjw5fyh.fsf@oracle.com>
 <PH0PR12MB548100E1C4AD64EA35E22772DC6D9@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB548100E1C4AD64EA35E22772DC6D9@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH v16 03/11] content: Rename confusing queue_notify_data
 and vqn names

On Thu, May 04, 2023 at 06:33:38PM +0000, Parav Pandit wrote:
> 
> > From: David Edmondson <david.edmondson@oracle.com>
> > Sent: Thursday, May 4, 2023 10:28 AM
> 
> > >  \begin{description}
> > > -\item [vqn] VQ number to be notified.
> > > +\item [vq_index_config_data] Either virtqueue index or device supplied
> > > +      queue notification config data corresponding to a virtqueue.
> > 
> > vq_index_config_data doesn't exist.
> > 
> > Given that this is an anonymous union, perhaps:
> > 
> > \item [vq_index or vq_notif_config_data] Either ...
> 
> > >  \drivernormative{\paragraph}{Available Buffer Notifications}{Virtio
> > > Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device
> > Operation / Available Buffer Notifications} -If VIRTIO_F_NOTIF_CONFIG_DATA
> > has been negotiated:
> > > +
> > > +If VIRTIO_F_NOTIFICATION_DATA is not negotiated, the driver
> > > +notification MUST be a 16-bit notification.
> > > +
> > > +If VIRTIO_F_NOTIFICATION_DATA is negotiated, the driver notification
> > > +MUST be a 32-bit notification.
> > 
> > The above two should be inside itemize?
> 
> Both suggestions look good to me.
> Given rest of the patches are reviewed and it is already v16, I think I can cover them right after this in editorial changes after merging this.
> This way the majority of the work of this series and subsequent patches doesn't need to wait another week.

Did voting start already? If not you can post a new version
just before voting if you already know what you want to do.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

