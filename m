Return-Path: <virtio-dev-return-11951-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20A45C761A6
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Apr 2023 06:33:28 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 0BF36370FD
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Apr 2023 06:33:26 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3567B98668A
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Apr 2023 06:33:25 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 265139863E4; Tue,  4 Apr 2023 06:33:25 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1441B9863E5
	for <virtio-dev@lists.oasis-open.org>; Tue,  4 Apr 2023 06:33:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: BiqPvfGXM6qdOFHNqmm8hw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680590000;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ok5lwzPGeUNv0NHclJghBxK74E1IF2gmAJlYAs6xPy4=;
        b=DmORU0sGe4XRrl7yEfj3FDIaRZkef4Mk0D/nl5X23MWHrdFlMSN5Ke1fSdt2l5eUQa
         RwM6jPxdewr1LEA6mgQuqBVtJKcaDGC9P0lfKfi3kqc/oZ7ye70INjEqhBiZvGFQ7e9I
         3nqyaUdWoQlt8h4L5I8AezOg2esuCuGA4sDkzSSNmdQuw2xboFBce5DWcSilW/P6KGIM
         aSF2Mn+xqS3NDZnbt8hxfcrhwQW9AYY+ajq/wVofo/TksKgWeEQLpS1PaEmP4pAuiM2L
         fJjKa0t/hISoogHl549Q7JRyx8f82Iin6ta1eVMj4VrRgx2M6TI1kMPa60EJBdyO8bdu
         yMig==
X-Gm-Message-State: AAQBX9e4qbcXhWpXXf93/spQrCslJOj1j8YX1w5Cy/Vz1WfKR6PEhTHr
	U36gfYypGCVhdOmkYpeScdF+Q0Xdu7mKe4yIk5EcLlqICrwhec3zf/1QFIo2iOyxr0I0C/95PbA
	R6ZuVGepL7Af8RvDsaKYfMoQ3Lr41
X-Received: by 2002:a17:906:6987:b0:92e:c4c9:7a43 with SMTP id i7-20020a170906698700b0092ec4c97a43mr1223809ejr.25.1680590000046;
        Mon, 03 Apr 2023 23:33:20 -0700 (PDT)
X-Google-Smtp-Source: AKy350Zo5WWQ1H52m3YcQu6pnGQRiuZjgysxYjPpNS00Bt5M9cMjLSYNcZ/f7tl6E0MwpKU6xKmxTQ==
X-Received: by 2002:a17:906:6987:b0:92e:c4c9:7a43 with SMTP id i7-20020a170906698700b0092ec4c97a43mr1223790ejr.25.1680589999771;
        Mon, 03 Apr 2023 23:33:19 -0700 (PDT)
Date: Tue, 4 Apr 2023 02:33:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Halil Pasic <pasic@linux.ibm.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"sgarzare@redhat.com" <sgarzare@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Message-ID: <20230404022928-mutt-send-email-mst@kernel.org>
References: <20230329212341.465843-1-parav@nvidia.com>
 <20230330191114.77acd860.pasic@linux.ibm.com>
 <PH0PR12MB548165C4B11375F8C7EE7AD1DC8E9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230404033622.4b749f89.pasic@linux.ibm.com>
 <d62d2090-de0d-0ea6-5c85-ecf19ae828c7@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <d62d2090-de0d-0ea6-5c85-ecf19ae828c7@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: Re: [virtio-dev] [PATCH v10 0/8] Rename queue index to queue number

On Mon, Apr 03, 2023 at 10:57:35PM -0400, Parav Pandit wrote:
> > Both solutions are equally consistent in themselves, but I
> > argue the latter is better because:
> > * it is more consistent with historic usage
> Well index/vqn has mixed up anyway now.
> For historic reason, I agree that index is right.
> But it is too late now.
> Comments have not come on time.

Why, is there a deadline? Is this blocking some other feature? For
something that is supposedly a cleanup we might as well get this right.
If you guys both agree index is better, and at this point it sounds
convincing, why not do it? It's more or less a machanical replacement.
It's not like there's a lot of word smithing going on here except for
8/8 which really works with index just as well.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

