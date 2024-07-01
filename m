Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E3D381C4
	for <virtio-dev@lists.linux.dev>; Mon,  1 Jul 2024 21:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719867685; cv=none; b=PL2WHLZB2jbCDmML6UCHqtYFxIM297dQsaHMGamEXQIOwnhIFkDv52vEt+vgsCAhbf5yfZQ48iz6O0tjAqwZLlZ99pp7H8WjmxEX+EExh7KGTHb6t3L8V0YPlIZeVZvsZHdW5YVpD1t9iw4jjHyIhsNsMxSKGzzpwd9zdaImP3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719867685; c=relaxed/simple;
	bh=HWx2B1uJVrIPhz/ElFZ4yGYTwbINqcZ7oi2wqMhSL/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=oF9lnykWSrFBEzjPZuAbUrPX4YT3xldzla30tH8HkPUGnOG2qny8sTb4D2vUUYqkgoOjpsdrOiJd930yLKPmDuZ7wtTlmbVpp+Fjs//hdrhP/lhm6DVjUUefae6LwYyj64K/lns0wxoEpkQz1ek4Siz5Bs8JtP0ikE7CQI0In/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xg6vakuy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xg6vakuy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719867682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zxaxIYiEdM3WHAbLjnR2wHPc70AniJv5IeStPuA03VQ=;
	b=Xg6vakuyRILqgddB4ptO4SLOVrrgdg9j2YA8QjVLPf2Rs31ybosdGffoGU/ki93bT0gP6y
	po/892NLu1migi0PR7oELatT9pSwmlVNqKSDSrw3xlbuRiqCv0CugPEJ0rKLtcy1WoDOI4
	+hDM9hHQvnxNJJ70w8KkSvXWgSIZtKs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-HNs1o_09N5udokjXSFmUUQ-1; Mon, 01 Jul 2024 17:01:21 -0400
X-MC-Unique: HNs1o_09N5udokjXSFmUUQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4256b7702a5so19292235e9.1
        for <virtio-dev@lists.linux.dev>; Mon, 01 Jul 2024 14:01:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719867680; x=1720472480;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zxaxIYiEdM3WHAbLjnR2wHPc70AniJv5IeStPuA03VQ=;
        b=NkxKmhdw9xIc7+QOXUvfRCSARyaWMCSbOGjPr7UXd0hnwEi/Skm0dlyVT0kt0/Q06+
         y81/+Pj9Thbb3SfXffMeGx5R6jGW43XEFhZe6bBQ7tlwIjWsaMX1cALTDG2/0D04H/Ps
         8wBe7Dh4RMDnvJj73KKIM9BejU0zUddQFDF/TSSIhopewUj3HKLjol+RuLBX9OZMIerz
         0AQSPlyuTFY39h2NqnSJ3w1Lcg7bJS51WOYL1rxS54nHc3m0assrcJoeS3s/iwT0xh0M
         eb1I1Gdx84s6ER0dzl9dQ3jAMgPFYR0x9euiuDYJlTLn8y4MnmyBtM3It3ZQXmpy8HS7
         OMmA==
X-Gm-Message-State: AOJu0YyGe/63PA1iAOyjl3xejMDxgXrcr17KaTH/Tx7AV1WIUoD+Eeke
	jEAWWl09JLTyMGB0AxmR2LF2CkvIahOppHJitD8BKxXe9AJQL8N+LP6M2kLpj2WSS9KYbGAfOk9
	9N2HzlLgb3rpcqmdr+j0n+RyruAp+agvigtvqZ4Ppnnu2xyAetQaQMmsJSnc=
X-Received: by 2002:a05:600c:46d1:b0:424:7425:f8a0 with SMTP id 5b1f17b1804b1-4257989f82amr67038945e9.15.1719867680069;
        Mon, 01 Jul 2024 14:01:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHe5z0Wnt0jDGDXiQ6Pqlk1Wcoyc3SUArY61d1X/AdnN8bCJ/3+UjHfOp3eOXeqrkWZqhivvg==
X-Received: by 2002:a05:600c:46d1:b0:424:7425:f8a0 with SMTP id 5b1f17b1804b1-4257989f82amr67038765e9.15.1719867679536;
        Mon, 01 Jul 2024 14:01:19 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b09a2bcsm166962455e9.36.2024.07.01.14.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 14:01:18 -0700 (PDT)
Date: Mon, 1 Jul 2024 17:01:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Roman Kiryanov <rkir@google.com>
Cc: virtio-dev@lists.linux.dev, JP Cottin <jpcottin@google.com>
Subject: Re: VIRTIO_VSOCK_OP_REQUEST with the same src_port from a guest
Message-ID: <20240701165704-mutt-send-email-mst@kernel.org>
References: <CAOGAQepPkUDF8vmzRiG41xOGhFdDuq8-EHmdTrdVrK6E346G7A@mail.gmail.com>
 <20240701142831-mutt-send-email-mst@kernel.org>
 <CAOGAQepE5G+yR0FQMFW8oZ24p0DVKZgmkDJsB09hbxF+P7KvCQ@mail.gmail.com>
 <20240701153918-mutt-send-email-mst@kernel.org>
 <CAOGAQerR1Y59gXq=PVSPtWMrDbxZWfA_T1GcOFSOqP09k7Mwuw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAOGAQerR1Y59gXq=PVSPtWMrDbxZWfA_T1GcOFSOqP09k7Mwuw@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Jul 01, 2024 at 12:55:46PM -0700, Roman Kiryanov wrote:
> On Mon, Jul 1, 2024 at 12:40 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > Can Linux driver ever trigger this? Some other driver?
> 
> I have never seen a driver with this behavior so far.
> 
> > If this is something that drivers don't actually ever
> > trigger, why does it matter how exactly the device
> > behaves?
> 
> I think there is a value in having the spec to cover all cases.

Well we don't really do it for other devices.
We focus on how things fail when it's important e.g. for security.

Basically spec has been out there for a while and we can't
declare existing devices non-compliant.
We can add a recommendation.
Given no driver actually does this, the value seems low.

-- 
MST

