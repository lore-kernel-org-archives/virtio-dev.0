Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83C76BFBF
	for <virtio-dev@lists.linux.dev>; Thu, 16 May 2024 08:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715847365; cv=none; b=NcKa2PKvLMB3sK82I16/QA+EuPRPQ3Sj36iMMj2+n4dd3qH1oIpvEB8r8/tbV84ziT754I4hAzc40Fybjb5ZzqTyjUNz84cAfFLP7NdtIA55JOjr6KveNMZ6feuUyjdfG4sYWU8AVkuxVSIdxRSFKcftG7IbE+s8Ds98oSDJoOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715847365; c=relaxed/simple;
	bh=b/pessfAypo8sKd0l72CM+1qkI6SBqzT05LNSQHoU8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=OrDKT1BENZp8YIMG7AjSo7Ogv9awwzM0Cn6oFTCeyAS956xCFzS5HUn5CJmiEa0m5Xq8aZHERBWLBJACkQstgxIaadegUPVcxNmhVrKS5XMThzQkXyvmrS1T9ZgYUFKBUgquY/v6tsdiSdQ+koe04tyPvrzZfHyPaJ9TpeAQV1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fNFSJSSq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fNFSJSSq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715847362;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Aqkkki1AuIdbpmg6p7QCapF9uu06hqRfEf+itSq9Oas=;
	b=fNFSJSSqI17bSRCzetzc+YwK/1Rdor0DBV5TsVO+WjgccuOU9ewhhBNrmRUQwWdN3Wd3bt
	r6C9nuPP857mxt5jIxJ9HkQm0c/ZLg9y7vdTdKYlFD1jTv4G1CXA8EcUQnO74+0o0DX1mE
	G3z3jTbxqvLhQTygrrHFBy0z8n+L+sw=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-srBEc9q-OV2C1x-1a4G9Cg-1; Thu, 16 May 2024 04:15:59 -0400
X-MC-Unique: srBEc9q-OV2C1x-1a4G9Cg-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-572b993d8ffso1977249a12.0
        for <virtio-dev@lists.linux.dev>; Thu, 16 May 2024 01:15:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715847358; x=1716452158;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aqkkki1AuIdbpmg6p7QCapF9uu06hqRfEf+itSq9Oas=;
        b=FiJpKrxJ5TLal+JA69LLDFGc6P/zErOswsJUX1ja79xmAlb4G+xpZZmJMpRkL11HQ0
         tmdfS0MMMQXGFWsj/8eb1jLz0p0tnc/sAh51upZtNv6eEwdichTpeCFxSar1KVOpZJiw
         TZXQ+gb3Y+iN0AFJLarpKITr/Tepr96EOM9V5sopEqcEhRYLayfNGm8FU819OvXRaHie
         reR0gBm6OfqCjN8mbAS3/r0vu13ab5AhsuJKEvUZl9jdBQgb9WYYKBv9DMjY9tPfq6iL
         vFveWTgyfPDzaHTTO9z2fio9g4mO8QKj4fJIYhK5hX8QP9/hZkmGPVzyzT/8PYFfffBq
         7w1A==
X-Forwarded-Encrypted: i=1; AJvYcCUC5EA0TRCpD4EHaJu40arVuEHuZM6hUaeT4jqkXr+SxBPegOukk5Utqf2RN3gInbMCYcge0QzwRdt2xyX3Jv5SFZJijWS4b3srGQ==
X-Gm-Message-State: AOJu0YyGnNIHkGIBJZbZSMOdp49qXxHBrZoE3l3yA+FWtGkOMA/jv2cf
	ZmNBMyhzj3Jolqh12fkC175shr+ottrUNXsU3mxeYBcF99YbGgR7TjaXQTF4zTDzMSQd/146W8a
	1u5Cf0OX7cALdmLNGtrqy1mz91L6SvyrSNRAE2xU9nW4ae9azlnApkW3bLbU=
X-Received: by 2002:a50:9b42:0:b0:568:cdd8:cf60 with SMTP id 4fb4d7f45d1cf-5734d5c135dmr16800621a12.8.1715847357979;
        Thu, 16 May 2024 01:15:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9hjXiK2Kpx3O+6BzoJySuXm6QBRq/3pbiW3A6lVpHbqrgcoo6hpmWtK/y48Ms0vZXfZrRyQ==
X-Received: by 2002:a50:9b42:0:b0:568:cdd8:cf60 with SMTP id 4fb4d7f45d1cf-5734d5c135dmr16800606a12.8.1715847357638;
        Thu, 16 May 2024 01:15:57 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-77.business.telecomitalia.it. [87.12.25.77])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733c322c06sm10379035a12.85.2024.05.16.01.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 01:15:56 -0700 (PDT)
Date: Thu, 16 May 2024 10:15:54 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.linux.dev, virtio-dev@lists.linux.dev
Subject: Re: [PATCH v3] README.md: update mailing list info
Message-ID: <te6tzbegqky7uz4skrag3yowet3phtq6nn7tegyrillgb4juwn@m4gi5ohfuk7m>
References: <8f5db33c96d685fcebca3579b05d09b64dd720d9.1715766697.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <8f5db33c96d685fcebca3579b05d09b64dd720d9.1715766697.git.mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, May 15, 2024 at 05:53:14AM GMT, Michael S. Tsirkin wrote:
>As approved by the TC, we are moving to a less formal
>way of discussing the specification, on the mailing lists
>provided by the Linux Foundation:
>
>https://groups.oasis-open.org/higherlogic/ws/public/ballot?id=3820
>
>Update README.md, CONTRIBUTING.md and newdevice.tex accordingly.
>
>Use this opportunity to explain when and how to use each
>mailing list.
>
>Oh yes, and device numbers are reserved through virtio-comment
>not through virtio-dev. Correct that.
>
>Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>---
>
>changes from v3:
>	update CONTRIBUTING.md and newdevice.tex
>changes from v2:
>	Use this opportunity to explain when and how to use each mailing list.
>
> CONTRIBUTING.md |  2 +-
> README.md       | 80 ++++++++++++++++++++++++++++++++++++++++++-------
> newdevice.tex   |  3 +-
> 3 files changed, 72 insertions(+), 13 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

