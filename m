Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE67516F848
	for <virtio-dev@lists.linux.dev>; Mon,  1 Jul 2024 19:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719862848; cv=none; b=j2WhiufadwRkKHlgTda7VW6URcSeKDJync8TygxjGSGClYRH+KirY8xJTIAlY9al5JFat+YxnI+D3UV+uZbL5qzT37U/FNu4WnbB9YmSldkk76KDeO4eykKNR3pPtYy/qvtUkuyzCyATXg1wLWLMzSiSsvmorx397CoW6yo5L3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719862848; c=relaxed/simple;
	bh=chQLTpqeDtMx4axx8M4K0YLLb58CYWzXdBkzkmcxVNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Unxp6uWwLfW0VWvERHyWdMgTCvxxweSxq02AC1KzjJZ5rXel7i1VK737yUxURlGkRvQ3lzKmzy2JtmJb81SBsCkCE889RokKWzY7dm+ABNFaSwQ0Z+8un6eDJk3+283qMvBHcgDgGXLuD5fUO3WmfeSrLS6sEmbu4FFZKkHZYvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RQWoCHpV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RQWoCHpV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719862845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e+joB17uLqwXtFE3II6YSc+vcUpj3+Hco9j9lAwGlfQ=;
	b=RQWoCHpVVqhCA9Eym6UakkNdWVpIfOEgP+GcPxWGg+qGi2BYd4TvDYgK884zrfA4rctLSY
	NT/KsVIB/wvUshoX0qjzqWn2y3NRFhU+/i+V/NLl/INUYmyQF2ZBtqWbUz4rtGnQ8LHtuX
	IUIttXS+oqPHwif8T6RFFUdMcxBEPXY=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-Y4QmgnmKPWuZovOnNmdUsQ-1; Mon, 01 Jul 2024 15:40:44 -0400
X-MC-Unique: Y4QmgnmKPWuZovOnNmdUsQ-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-52cd7e63b2aso3197935e87.3
        for <virtio-dev@lists.linux.dev>; Mon, 01 Jul 2024 12:40:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719862842; x=1720467642;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e+joB17uLqwXtFE3II6YSc+vcUpj3+Hco9j9lAwGlfQ=;
        b=Edjo6xtp5C6mjuWFiqwVl2Wk2dMn9sCwJf++IhjoCpXmiAmNKmw5JJOzvKQJ79Tab1
         yws2BpZDUw+ShmPLzG6sfWNkzaHRqjJsqDTfHqNM2yty37Aky6lAJypyLd6obGXu0nY7
         NgUrcQAFxjk2D4FM+HbXzZVWCcip1oT8wdx1gBQMNV3ZIscRBTiv7/XAV5Q3UKKDK4l/
         KZJMLFHlpKlmMOKv8Cn1wDng1zEAdS79m7KGP0txur5fymEnjTah+7dPkVHO+WAS6zLB
         nkcQImNajfGFofFSL758ji1afojVkZWp7kjKHeVfd55z42icKmpg1KkFnNEatptzFB8y
         LY0w==
X-Gm-Message-State: AOJu0Yww/B17d4felIaGn0Sl4bTM/0lOUfivatMDcr2zi//1GocFIfvC
	sOAzyZ1uGfgFRKBwMZVoSOdSLtrw7fqkpfSju/R2+8aSO1BQ9GOYhK5R5Le+k85NEQSVK/QZgTO
	AzePMXHDOU2+wkiuC8G5TMAWu5K0IaolyZtNp+migzQWekA8do/tNRXs49uE=
X-Received: by 2002:a05:6512:1309:b0:52c:e670:7a12 with SMTP id 2adb3069b0e04-52e8272be79mr4366165e87.60.1719862841783;
        Mon, 01 Jul 2024 12:40:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IET0rMgN/Yp9i9FahAJSy7UQy6AbsQbfQkaq0Ibn5DR64JTgh2eHiTcKwxkBBgDdprlJoeuqw==
X-Received: by 2002:a05:6512:1309:b0:52c:e670:7a12 with SMTP id 2adb3069b0e04-52e8272be79mr4366146e87.60.1719862840884;
        Mon, 01 Jul 2024 12:40:40 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b09abbfsm165580315e9.35.2024.07.01.12.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 12:40:40 -0700 (PDT)
Date: Mon, 1 Jul 2024 15:40:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Roman Kiryanov <rkir@google.com>
Cc: virtio-dev@lists.linux.dev, JP Cottin <jpcottin@google.com>
Subject: Re: VIRTIO_VSOCK_OP_REQUEST with the same src_port from a guest
Message-ID: <20240701153918-mutt-send-email-mst@kernel.org>
References: <CAOGAQepPkUDF8vmzRiG41xOGhFdDuq8-EHmdTrdVrK6E346G7A@mail.gmail.com>
 <20240701142831-mutt-send-email-mst@kernel.org>
 <CAOGAQepE5G+yR0FQMFW8oZ24p0DVKZgmkDJsB09hbxF+P7KvCQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAOGAQepE5G+yR0FQMFW8oZ24p0DVKZgmkDJsB09hbxF+P7KvCQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 01, 2024 at 12:16:15PM -0700, Roman Kiryanov wrote:
> Hi Michael, thank you for looking.
> 
> as I mentioned, I have never seen this happening.
> 
> But this code path (on the device side) exists (e.g. insertion of
> <dst_port, src_port> to a
> hash table says that the key already exists) even if it is never taken
> and I would be nice
> if the virtio-spec mentioned explicitly what to do there.
> 
> Regards,
> Roman.

Can Linux driver ever trigger this? Some other driver?
If this is something that drivers don't actually ever
trigger, why does it matter how exactly the device
behaves?

-- 
MST

