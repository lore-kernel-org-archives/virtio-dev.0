Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82E615E88
	for <virtio-dev@lists.linux.dev>; Mon, 27 May 2024 06:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716792084; cv=none; b=dhRDXicywTndWstI6DZANUlV/6C2+hdscvbOtgAQO9APaLyJKplniXaA6ih4J8yAYbBsQiqCnEI9b2Nl7MfOzXWNG1ptZrSiK1k5h0l61KZDAsbEXB3WDLhhHWxeNlQPtAwAl+xxhhbsUBeaavsfdvRX4wR1m22Pj9VL5iNLMD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716792084; c=relaxed/simple;
	bh=xGgfKTumJCAzyqqV3d2z3/QvdVGnZyfgZdQbXrtZtJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=hlKSK+8bh//ODkoswLjld7lLK/bfwW4Sa6FpaX4CjQJ8/PqDMM7K0Pc8wgJ5McOvRycrz+zMMnvJANve3KCfS9OKVggJrY+I1qEc2dfARMqOgzXwYisv3fGpBVwe/ptNza2m53IGA+fRFTCg4uOjaogwZg+UN4i8Z8Fk0F52xdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kdj7ep9a; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kdj7ep9a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716792081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c90bN4bCmxJ96CLf78qxhzeX4X46ooVNld3WbAEMBe4=;
	b=Kdj7ep9awdLGcMRDxw/g2JO0L598Ke2srx7vsADR/IIBpAiccgA699M6FmyC4QgO1R3CkX
	pLia5iiXQXi+gX2xbmFAA982lJa7At5/uL0UJ9POOIzI/DpXz0zT+pbf/YozNfJ/UQK80s
	G2KPluL+yantcllG/05zLigi/oUWbR8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-eyZK-FGEOs6P4dlhXtWgrg-1; Mon, 27 May 2024 02:41:19 -0400
X-MC-Unique: eyZK-FGEOs6P4dlhXtWgrg-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-35507e4c41dso1056696f8f.1
        for <virtio-dev@lists.linux.dev>; Sun, 26 May 2024 23:41:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716792079; x=1717396879;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c90bN4bCmxJ96CLf78qxhzeX4X46ooVNld3WbAEMBe4=;
        b=ACJGPBqW+dh1WAf8FR/rIJGb9YnOiZWuHYcgMUyNUNBOteC9P+0fCB6vtezX/Fc9AS
         k3vK8CarNSUwltWqv00p/zfzUjiBjSopyfjF+Cmv+yYH0cTtkl2sHNlscPFBUxRzwguK
         Owf5GzlgguANpLpN5KLtfPPzJl9umc3iJHn4tmH5C5e739WgpXfxHlK2iETOLN06i0Bp
         jRyAimxJ917PewPAaPS3BvcHOvfK9DYt+0xHMuUGS8cugNLGyJV0na1rD9S2YVEt9kao
         KOOkV1HvbHcX7xiwYxcemHNK1wTbVrfi+Ll78kOfdUx5ml/P+ZQhH19VKDpZ+teC82kO
         YenQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnMZQoYbRWPBepWl5XoXf+DvgRE5Bg6nob4CbA8QFbhJVOIyAwtmRNlbPzEFtgxLjShUDCjhk22hBS1wvcZzOM/JB0wgylLIFZHg==
X-Gm-Message-State: AOJu0YyrVKUBHfoKltxMWX1+H1MjHXc03jx1A7QWPbb8gtM5E4Wg4JrJ
	6iUiEtRuc4Vf//22zQog1kVbqldU28XIwFi+jCNoEwBpFJ8xYaPEft0Ls7dQ6U9kizX8AFyXZ01
	4AGgPhKPs1uMJ+pGPPW2Bu/ku3EN+JeIAn0hYy1WNyPswL9HGEk89/UxfONA=
X-Received: by 2002:a5d:47ab:0:b0:357:a6e3:8748 with SMTP id ffacd0b85a97d-357a6e3877emr3990068f8f.1.1716792078532;
        Sun, 26 May 2024 23:41:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjtA9kIKx226xQdS/ugV2TUje3Mhx+t2f7c11epYaY2oJwBLNV/841RG7a1zvfu7H3ER9HDw==
X-Received: by 2002:a5d:47ab:0:b0:357:a6e3:8748 with SMTP id ffacd0b85a97d-357a6e3877emr3990043f8f.1.1716792077954;
        Sun, 26 May 2024 23:41:17 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:342:cd82:9c62:7faf:9d73:ba3f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3557a090805sm7997202f8f.48.2024.05.26.23.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 May 2024 23:41:17 -0700 (PDT)
Date: Mon, 27 May 2024 02:41:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: zhenwei pi <pizhenwei@bytedance.com>
Cc: virtio-comment@lists.linux.dev, virtio-dev@lists.linux.dev,
	david@redhat.com
Subject: Re: [PATCH 0/1] balloon: introduce 6 memory statistics
Message-ID: <20240527023734-mutt-send-email-mst@kernel.org>
References: <20240513121005.459013-1-pizhenwei@bytedance.com>
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240513121005.459013-1-pizhenwei@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 13, 2024 at 08:10:04PM +0800, zhenwei pi wrote:
> Hi,
> 
> There is a previous discussion about the new memory statistics:
> https://lore.kernel.org/linux-kernel/20240423034109.1552866-1-pizhenwei@bytedance.com/T/

> This may be helpful to describe the usage of these counters.

It's ok to add a link but you really should include the
motivation with the patch, and preferably in the commit log
not the cover letter.


I think the qemu patches actually include a lot of good info
about the statistics collected. But they also raise a lot
of questions that would be of interest to the TC.



> 
> zhenwei pi (1):
>   balloon: introduce 6 memory statistics
> 
>  device-types/balloon/description.tex | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> -- 
> 2.34.1
> 

