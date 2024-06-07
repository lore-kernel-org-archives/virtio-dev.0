Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C497A15B13F
	for <virtio-dev@lists.linux.dev>; Fri,  7 Jun 2024 09:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717751351; cv=none; b=dtDTrrRE1PPjjjk+UXBLYsbgHAWA8r3HFpIVcyh8d4HhcIyIuYxHygx8wwo22fkwFXTIPh1iFe7zKrgUGCW8gy8uv5WqUDIYtWkAvNuGxgo+D7OZ7V1u5+ZM1/B2MsNXOgchcTOcIJKD/AvNMnxIpi2FGopmEV0jgNs5eTJE4Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717751351; c=relaxed/simple;
	bh=2g085Qv2sZ+lzpHJ6d/morSwEobDi+HUPO3OoA/Wcfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=RjGZEgjB1ndEQTHLU9DFnhWC9v7pXe9BvACmG6wCeHeR4Co7xfW82yj8ePgAcNOD2fBApGWmvT7Twnc+bhksciK5Vo+Qt9yiKff9KrwqUKAARE5bLPFHBpiOXu8r16q6W5a6g6i5ffTb9N9JilObrOxjwooKNKUEDhrm3qvmp8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bahr3dP3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bahr3dP3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717751348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B+hA8Ge9BqN2Oo6x+bvaug2r1jAxQeeVpqVkv24yF+U=;
	b=Bahr3dP3h3gIUseL5mEMCHW+HpfFdT5gG5CHNUbnz4L5DvrGcQSepzViM/nNZ3jwI2YdAO
	6V5w3UvphkOWQE/e3Er6LNsUorH8R4BSwafMezTa83t9XB5isyCBooMkT71dIgWHMy94w6
	/f9bqfGqfDfabcjO+UM38RXlTIgimwI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-7c14i2gHMIaPv9_pr4VsQw-1; Fri, 07 Jun 2024 05:09:07 -0400
X-MC-Unique: 7c14i2gHMIaPv9_pr4VsQw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a6929fc5b52so108144766b.0
        for <virtio-dev@lists.linux.dev>; Fri, 07 Jun 2024 02:09:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717751346; x=1718356146;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B+hA8Ge9BqN2Oo6x+bvaug2r1jAxQeeVpqVkv24yF+U=;
        b=Kg6vSu30vxoQWOuf9g1C8WjtDVBsLhjc86X7ZZwzic23kz3jr82zQ8BwX5hGa5mAB4
         jlo1v3teCZQI+8rZXl3Iu3jfp93uCX2zdaCjtROgtHk46u0qLnfjvPcP+PMxvnYd5QbD
         tnFTnRn84Tj+HVLWuwOptP6wNJC17hgJ2hC+MbX3lg7jvjLyI5g998IK2TxKFiYGsoUO
         5HrJUPfakdmX8cotcR5KS6Dg5AqTvapu5057HviQEW3SUAp05IAQJElvpjZOtu8Iqoty
         fyS0I+D6vMLAhUvfY3uIhQcH1PudT0ofA8d0C7V0xJCOLcgAp5CMWLBmssL4A0QF6fZL
         lK3A==
X-Gm-Message-State: AOJu0Yzl5N6B7P0LhbHJZPOCHkY8kZUC6GSjSFtnVumtawIhE2ODKFw5
	E8iyhZdx4PF6mMZ/sVAKod8yHFzhvwegVtyOeTyZBRwssPRknTIlFhOl4rwAe1EEOKeDK0mnGIi
	DoUe5AoDnMF08TFzIYyDiqGFCaph/b9U+b07EvOq5PmlMcrIsggfmhFhyG9U=
X-Received: by 2002:a17:906:48cc:b0:a68:e7e0:1fd1 with SMTP id a640c23a62f3a-a6cd5616af7mr139567366b.7.1717751345966;
        Fri, 07 Jun 2024 02:09:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFeH+nc8VxKm7H4zo7Jyw3/GG2IBw4hOvl0fOyKmEAvw8ocTKoS9aGEe5N4RDOTTILMmK/Vfg==
X-Received: by 2002:a17:906:48cc:b0:a68:e7e0:1fd1 with SMTP id a640c23a62f3a-a6cd5616af7mr139565566b.7.1717751345434;
        Fri, 07 Jun 2024 02:09:05 -0700 (PDT)
Received: from redhat.com ([2a02:14f:176:d5af:1ef7:424d:1c87:7d25])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c80581f42sm213657566b.1.2024.06.07.02.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 02:09:04 -0700 (PDT)
Date: Fri, 7 Jun 2024 05:09:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Harald Mommer <Harald.Mommer@opensynergy.com>
Cc: virtio-dev@lists.linux.dev, linux-can@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Wolfgang Grandegger <wg@grandegger.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Dariusz Stojaczyk <Dariusz.Stojaczyk@opensynergy.com>
Subject: Re: [PATCH 1/1] virtio-can: Add link to CAN specification from ISO.
Message-ID: <20240607050716-mutt-send-email-mst@kernel.org>
References: <20240606141222.11237-1-Harald.Mommer@opensynergy.com>
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240606141222.11237-1-Harald.Mommer@opensynergy.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 06, 2024 at 04:12:22PM +0200, Harald Mommer wrote:
> Add link to the CAN specification in the ISO shop.
> 
>   ISO 11898-1:2015
>   Road vehicles
>   Controller area network (CAN)
>   Part 1: Data link layer and physical signalling
> 
> The specification is not freely obtainable there.

This message really should not have been posted to any
of the lists that you copied.


> ---
>  introduction.tex | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/introduction.tex b/introduction.tex
> index 8bcef03..72573d6 100644
> --- a/introduction.tex
> +++ b/introduction.tex
> @@ -142,7 +142,8 @@ \section{Normative References}\label{sec:Normative References}
>      TRANSMISSION CONTROL PROTOCOL
>  	\newline\url{https://www.rfc-editor.org/rfc/rfc793}\\
>  	\phantomsection\label{intro:CAN}\textbf{[CAN]} &
> -    ISO 11898-1:2015 Road vehicles -- Controller area network (CAN) -- Part 1: Data link layer and physical signalling\\
> +    ISO 11898-1:2015 Road vehicles -- Controller area network (CAN) -- Part 1: Data link layer and physical signalling
> +	\newline\url{https://www.iso.org/standard/63648.html}\\
>  \end{longtable}
>  
>  \section{Non-Normative References}
> -- 
> 2.34.1
> 

