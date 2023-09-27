Return-Path: <virtio-dev-return-13976-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10148E82CA6
	for <virtio-dev@archiver.kernel.org>; Wed, 27 Sep 2023 15:31:28 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 44D9B120D58
	for <virtio-dev@archiver.kernel.org>; Wed, 27 Sep 2023 15:31:28 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 217C49866AC
	for <virtio-dev@archiver.kernel.org>; Wed, 27 Sep 2023 15:31:28 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id F37859864A3; Wed, 27 Sep 2023 15:31:27 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E14C99864BB
	for <virtio-dev@lists.oasis-open.org>; Wed, 27 Sep 2023 15:31:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: VSMh1BVBOeOGA7Dx_B84Xw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695828682; x=1696433482;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a9Mk5i0Lw9ZjTO+hCoh86uGs2hyQkZhTgsvCxaiiw70=;
        b=gFpNR67tgXptktpvsu+1Yr4I17o+myLCwJY5f0AZDBnPQtsYkRul6kpJ9Ou6sWgrCA
         vTY88QBxIAStghx45jG1TiEzNsxErcOZgGmZkn/o/eUYgokh+qGd3XoxLZSC70E4pJEj
         8gcCFMJzTCYYnW5bFHbQXNSGgYZ/njBANVzCetNZUY6VKmEWdBWJqSP85NhVYUgDOrjn
         vuVzbqh086dHV5beNj/hn9pzv8V+g+2caiFvBgDIZCfZFI4OCpleB8e8otH1AflTQbma
         hg/dyCk5Yb39Y8LOo38v0k4Av169RytsXSIRsZlUcX3m1VfcxCpCPAcwuhBl9FfJefj+
         Cvnw==
X-Gm-Message-State: AOJu0YzzjFJ15rHDZMgYOrrWnEf+hNbPAdfBiHyB+qmkUVccf/kG6x+s
	wlePEG2hUe15vtx4VIPSYbGQ10xipLdOSP8QKhm4jp/LNjQrp1narscm8gc/zyJmzksRszAkPsl
	74iTf8DUBYZtmQbrGYEXpvgfGlRn2
X-Received: by 2002:a5d:6a0b:0:b0:323:1d0a:5562 with SMTP id m11-20020a5d6a0b000000b003231d0a5562mr5194747wru.6.1695828681925;
        Wed, 27 Sep 2023 08:31:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGM4wsOhrWiYKYH9etWXTUQgqe3jX8/4XPj/rMesOGv9j2O146qvyjv4Cwc9k+/Cso5mBCiEA==
X-Received: by 2002:a5d:6a0b:0:b0:323:1d0a:5562 with SMTP id m11-20020a5d6a0b000000b003231d0a5562mr5194736wru.6.1695828681513;
        Wed, 27 Sep 2023 08:31:21 -0700 (PDT)
Date: Wed, 27 Sep 2023 11:31:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>,
	"Zhu, Lingshan" <lingshan.zhu@intel.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Message-ID: <20230927112729-mutt-send-email-mst@kernel.org>
References: <20230920054836-mutt-send-email-mst@kernel.org>
 <CACGkMEsn+9AqgmurN8-GXkcu8UxAr62_woJn3XZN+oUkTQNPUg@mail.gmail.com>
 <PH0PR12MB5481830365A80EF4583A3FFADCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEshxAU3Mjo7vczBNRb=P=FnenO4mPb9HJL0Ma3ZRbe-oA@mail.gmail.com>
 <PH0PR12MB548172996D62E37714A9776BDCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEtW88zJkDQL58NqLzzudq=f+SmzJ8bha55Dd2fd=FRGBQ@mail.gmail.com>
 <PH0PR12MB5481573D6EE3BE03FB7C3D70DCFCA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEvOxraeVB-5g7dJ-KBN=63kpmDfDdqaiQVyDh8egDjsGw@mail.gmail.com>
 <PH0PR12MB5481C11F6D68A892A091E2AFDCC3A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEvtyDXKHE4w9uH_9eqbckTGF8fZkNUuKr+mkzP0o31z_w@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEvtyDXKHE4w9uH_9eqbckTGF8fZkNUuKr+mkzP0o31z_w@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: Re: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and
 vq state

On Tue, Sep 26, 2023 at 12:37:19PM +0800, Jason Wang wrote:
> It's silly to ship a product without any debugging facilities.

The way I see it, debugging facilities ideally would be somewhat
separate from rest of the driver. For example, imagine an on-device
gateway that lets you query the internal device state.
Sounds better than trying to tweak registers that other driver
parts might be tweaking at the same time, while trying to
take locks that other driver parts might be holding at the
same time.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

