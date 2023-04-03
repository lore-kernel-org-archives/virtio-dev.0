Return-Path: <virtio-dev-return-11922-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF835C76188
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 17:39:45 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 3678E4434F
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 17:39:45 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 13BCC9863FA
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 17:39:45 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 031DC9863DE; Mon,  3 Apr 2023 17:39:45 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E545C9863E4
	for <virtio-dev@lists.oasis-open.org>; Mon,  3 Apr 2023 17:39:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: nCvcxRdaNkKYnhZpv3jm0Q-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680543579;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dz5jn54HVTndGGYzV6ETMhEx9ExZSY/tpkge414DE0A=;
        b=2IiABvXZmJdkYEgRMO6XXiO7Dikl+Ejy7SyuabPfElKvHUwyPVIZBYJnJi2+N36J9x
         XqOgma3PTD+zh/fuubp5blgY4f5fRacqof0sn5Me2KVgnHMbrACD32zSFuwQ1b5GvvLp
         xOme2dqzBmQyPzEfQybvgF2CoGMoCiNgZEqkrSSZ7vu/w1N3gNOZKYVT/P0Nfm5LBQy3
         lutibIAJh2Ra0S/pb8oiZPYs4C0kCh0SY2eMEVUbBViljpvJ+Ii44G1tAdqv9Jne4r63
         T6o+Ohe/CQMxtHACypMdo7nkyGBd4uPPP75//TJBfgu4lm9ceLrLoMLPyDqvAJgnJLqk
         NMlA==
X-Gm-Message-State: AAQBX9foDcYTALzGCWRaq7PgJ3tQyhvLEQxajq7UjNKrx36Csh9CDBUi
	c3rQrRXet36z8PDUjkOSKT9SbrGMuRmiebyOml64MWnICCOqcVNGrGr90hhd8tiGoE94CDRRRSF
	neQVq48BpzPAigq+Ie1EWFonDmtae
X-Received: by 2002:a17:906:7817:b0:8ae:11ca:81de with SMTP id u23-20020a170906781700b008ae11ca81demr35929629ejm.34.1680543579103;
        Mon, 03 Apr 2023 10:39:39 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZN4kwSEQ1vAJaPwMAODdDN6shJlr7zjgt4Wvzv4YyX9laB1E3lQ0cIhFxpemIJGapacnm1AQ==
X-Received: by 2002:a17:906:7817:b0:8ae:11ca:81de with SMTP id u23-20020a170906781700b008ae11ca81demr35929613ejm.34.1680543578866;
        Mon, 03 Apr 2023 10:39:38 -0700 (PDT)
Date: Mon, 3 Apr 2023 13:39:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Message-ID: <20230403133724-mutt-send-email-mst@kernel.org>
References: <0dcd9907-4bb0-ef0d-678d-5bc8f0ded9ec@nvidia.com>
 <20230403105050-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481D50080A3A7C5F81E3F62DC929@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230403110320-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481EC65708410304D9C1EA3DC929@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230403111735-mutt-send-email-mst@kernel.org>
 <20230403113130-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54815BFAFF4BC17F37864B8FDC929@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230403132442-mutt-send-email-mst@kernel.org>
 <e48d2980-2a23-29e4-0628-cd812f324985@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <e48d2980-2a23-29e4-0628-cd812f324985@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH 00/11] Introduce transitional mmr pci device

On Mon, Apr 03, 2023 at 01:35:01PM -0400, Parav Pandit wrote:
> > So something like a vq would be a step up. I would like to
> > understand the performance angle though. What you describe
> > is pretty bad.
> > 
> Do you mean latency is bad or the description?

I don't know. We need admin vq and transport vq to work.
You describe latency numbers that make both unworkable.
I am interested in fixing that somehow, since it's a blocker.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

