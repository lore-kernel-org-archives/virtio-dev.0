Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A65D26981F
	for <virtio-dev@lists.linux.dev>; Tue, 25 Feb 2025 14:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740493295; cv=none; b=KJgioTuxDF+2SYerk8CXAUJtpNbQ4+iQF0OImZadAp/cb/3zJaii/q2/SEgpUij4iGqJpLoYyhG9RlIrmO3CnlxOehUwBWT5967YxBahUA53L6luu0NEHQ6wbRhy/tXTHiflDFxIYbUpzZQpdQL46LmbjJ1q8ocp7vyXWaMPA9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740493295; c=relaxed/simple;
	bh=JOzSXnruxMx8fo4ynquuHZbCjEVyeQDk3Gw08yi3rfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=vBC9K/os2eOINZ5fmB10/1VHALUCexFfGUC13i7lbS5tYVfHM2zKhJkBSADtVgBhc2//YAIAPeYkaN0y/Xcxb3sBYfewhxsR2d0AyvIVRWolkAHnyROrtg5QQ/5Pyq8IUdMa2IsiKzxrJpLY80xWJsWKv4C6DT/sZa8xhCqi9B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dV+gF3aB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dV+gF3aB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740493293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SFFVttm850UqVz1pmb+AlnJQK6y1OGWuLBvoqE/ivD0=;
	b=dV+gF3aBJG2ObjJtIOteRp5o4ZeAAdcEKWswESee9ZMQmGHBUaahzzAvaGbeDOp5nEvgMS
	yxigvz2BdKIrv3feZK9uw/ziY+BM2BRNPAMbzrRQzSoNbao8v6JweV1l/2DhQ6xb2pjIi7
	JzGOCritUGnPMlHVwgTaJeMHu1uAWP4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-fH5A4nrMNxi3k_GTEDBlWw-1; Tue, 25 Feb 2025 09:21:31 -0500
X-MC-Unique: fH5A4nrMNxi3k_GTEDBlWw-1
X-Mimecast-MFC-AGG-ID: fH5A4nrMNxi3k_GTEDBlWw_1740493290
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-38f36fcf4b3so3500468f8f.1
        for <virtio-dev@lists.linux.dev>; Tue, 25 Feb 2025 06:21:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740493290; x=1741098090;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SFFVttm850UqVz1pmb+AlnJQK6y1OGWuLBvoqE/ivD0=;
        b=TF52qczeghNPYIh4jYoUdFuIqh+TmFIy2Hqr7BoK2AXrkKLt2o8P2Dnp66ZLYaW6hd
         S839T87zPRnglYKfg0VoK+jsu+LLgtoyfkF/GzT3forW5Oo1x68X10Ali1G4unMmuHcp
         4t1C6jnoMdr6wFGMkXutWULubCWYjJFlnqcwQH+W0pzYjxycp7NUL0KVf8M4yCxnVABC
         FNPzw7EFNmEGoKtgjsU/CSjBuiGRoiToy9R1SXQDdRBDHv6/gi09UMZWEIqc9bDalQu8
         SUmKvMK1Bdhp8ukBgH4ANd9ybU4VyvLjJRE3F9pi4ascEo765MmJgHQKce7mKzQZPse1
         FETA==
X-Forwarded-Encrypted: i=1; AJvYcCW5rl5XrHq4ycCns6yOmCn0ItOeCW+IzE4tyRrVgjcYKS9zD5X9dRVotH6qlO+YqGj+kgVD0ay33SxB@lists.linux.dev
X-Gm-Message-State: AOJu0YwlbaVSUbITgqOqM8RnXrusQa08GhE4YgivuPd4bbpbOhPp/fql
	Aj4ap7IzMJ35Ph2/uIfa1Sb+WuvkMdW+/l/t2BP/Uofc3mrBAONe5yU/CfooIumRVyKxb8aaF44
	nyfpmlIdJpBNUfM8HbTTileqPGNzIyd6q7SikGsmahHhenjiguzoE4BZdSHU=
X-Gm-Gg: ASbGncutlLeWvuLEzpKhMhPzgpQR8hbnvK9XTTlvnm4fK2oQHn0k5/f2UW2iLl2ZaYU
	U9CpS89mOIV8bgxRssop0ne1MHkR6u37zpnsCOzm8B5egD83Yx9QwhsuITYRQ6A7bKXvDCuXdjo
	EpdTnUT1B8qw0bAI0udDSR7nR01KvsO1mexmPNaEJttD/D/NNmla0xZugjihI4+x7d7jDoeFlh5
	13V8jphaLLFKpz06V5EON2MVtwk1aQ50lIpkIC5XWUetJs8QzHDRnG82BBJSTSnU83PY1XJKNmL
X-Received: by 2002:a05:6000:401e:b0:38f:210b:693f with SMTP id ffacd0b85a97d-38f6f0ae79cmr12378090f8f.52.1740493290293;
        Tue, 25 Feb 2025 06:21:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFPzWsgH9v1k2HVPYkFXNJ3hhFz69OOLf5Yi+p9svSln8YhJs1OVyxaR00ASzjgQujycgWCZQ==
X-Received: by 2002:a05:6000:401e:b0:38f:210b:693f with SMTP id ffacd0b85a97d-38f6f0ae79cmr12378040f8f.52.1740493289721;
        Tue, 25 Feb 2025 06:21:29 -0800 (PST)
Received: from redhat.com ([2.52.7.97])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd86cb08sm2423039f8f.29.2025.02.25.06.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 06:21:29 -0800 (PST)
Date: Tue, 25 Feb 2025 09:21:24 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Simon Horman <horms@kernel.org>
Cc: Peter Hilber <quic_philber@quicinc.com>,
	Jason Wang <jasowang@redhat.com>,
	Trilok Soni <quic_tsoni@quicinc.com>,
	Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
	"Ridoux, Julien" <ridouxj@amazon.com>,
	Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Parav Pandit <parav@nvidia.com>,
	Matias Ezequiel Vara Larsen <mvaralar@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>, virtio-dev@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 2/4] virtio_rtc: Add PTP clocks
Message-ID: <20250225092115-mutt-send-email-mst@kernel.org>
References: <20250219193306.1045-1-quic_philber@quicinc.com>
 <20250219193306.1045-3-quic_philber@quicinc.com>
 <20250224175618.GG1615191@kernel.org>
 <vhlhes7wepjrtfo6qsnw5tmtvw6pdt2tfi4woqdejlit5ruczj@4cs2yvffhx74>
 <20250225141240.GW1615191@kernel.org>
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250225141240.GW1615191@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: D8pWyUkylyIhLqTEy1w_GsxF8qRh70i7X40FulkIHd4_1740493290
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 25, 2025 at 02:12:40PM +0000, Simon Horman wrote:
> On Tue, Feb 25, 2025 at 12:28:24PM +0100, Peter Hilber wrote:
> > On Mon, Feb 24, 2025 at 05:56:18PM +0000, Simon Horman wrote:
> > > On Wed, Feb 19, 2025 at 08:32:57PM +0100, Peter Hilber wrote:
> > > 
> > > ...
> > > 
> > > > +/**
> > > > + * viortc_ptp_gettimex64() - PTP clock gettimex64 op
> > > > + *
> > > 
> > > Hi Peter,
> > > 
> > > Tooling recognises this as a kernel doc, and complains
> > > that there is no documentation present for the function's
> > > parameters: ptp, ts, and sts.
> > > 
> > > Flagged by W=1 builds.
> > > 
> > 
> > Thanks, I will change the offending documentation to non kernel-doc. I
> > was not aware that these warnings are always considered a problem.
> 
> Likewise, thanks.
> 
> I guess it depends on the subsystem. And perhaps this is fine for virtio.
> But for Networking at large the rule of thumb is not to add new warnings.

Nope.

