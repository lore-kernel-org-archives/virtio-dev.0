Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085381E9B12
	for <virtio-dev@lists.linux.dev>; Tue, 26 Aug 2025 14:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756220221; cv=none; b=K8+ubLLYPb7RBcbsb0+o4SlbheAQBL3gGmSrky03g70DNFeGqaG4Xws5ldvKy56NwDfDCXMI3dFwrauF+J/AR4HFoaFhb/ENAYGWUEmXL6X7U+OcI6xoiwhk3ElDOj1u+rlEspjHWKJ7y/sEu87MULSuRoCYEHGD/KGzt7k7uH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756220221; c=relaxed/simple;
	bh=OTiL7ombdQtY8uA/Y5p3tKyryc+xRaxZ6pB1+/VtJQs=;
	h=From:Date:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pZiknaVOMFdTWr1+guzmgTBlP7LvAHziYnL2x+eDymgIeTeq+OhyaSFvL34qH3M4urIu4F3F9e3ZbtNpBgtvvqWKJasVBZhPdnH1X3BpApcHpwXH86WZJDzvOZJpVT6NsDaLLhzjzxwcRo/6QVDa2HBiG2KceaZPIqHe9s1nUNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UR7N9p+F; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UR7N9p+F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756220218;
	h=from:from:sender:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:mime-version:mime-version:
	 content-type:content-type; bh=OTiL7ombdQtY8uA/Y5p3tKyryc+xRaxZ6pB1+/VtJQs=;
	b=UR7N9p+Fn69qAMOp1kIrOCBbF9EAY9+vAeYRCFEZtHr6u/ZKD7BoqxCTs+LuruCsyONkjh
	JWwUtaGv+ucRBzDBYD/3B4AJUs2eaGUNgkaAP4dd75v9rQAJfEtjhOzyd9Wn7/mGjKQjjy
	j1TEWDIKv1t3ByggjJX4SWb0K9qsQGE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-302-bNURCkOyPzyUjzRNB7FSWQ-1; Tue, 26 Aug 2025 10:56:55 -0400
X-MC-Unique: bNURCkOyPzyUjzRNB7FSWQ-1
X-Mimecast-MFC-AGG-ID: bNURCkOyPzyUjzRNB7FSWQ_1756220213
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3c75de76cacso2394304f8f.3
        for <virtio-dev@lists.linux.dev>; Tue, 26 Aug 2025 07:56:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756220213; x=1756825013;
        h=content-disposition:mime-version:message-id:subject:to:date:from
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OTiL7ombdQtY8uA/Y5p3tKyryc+xRaxZ6pB1+/VtJQs=;
        b=g5Ktclb61Hb/uhgJpGuh0vWN/6/scTswPPlqVJwQyHcrGrKP9oJw6Yp89+KxPxwgo1
         o3btrCbFE/vN/VnoMLOvIuNntDwOkj74MZENYduRAUBwfifWZiaovONjRTCCl+K7by5r
         fiyAQCTmae7y88PIdzoXnpe8f1cChpPnhk19awhge17SdapVewwhlwlNibp/GnzPz0c6
         IPIOg3vMmH6m75+8Q3PmplpxbuH/F3LvYYmLA+lcRS79MTtlZbIHvux7CF1ZYfrBYTBg
         BKqJq+7sD+1FEsKMnAHNqR4y9gYgQoM33iLeMwyTQMm0JhmnRkGXO1nZp/yt+Ri/mBdC
         XxTQ==
X-Gm-Message-State: AOJu0YxFKtiEQgO7LSBKGiIooffxmFhhkJ1lYm1MApe6tGHfrGEOrWI3
	YOVoUjP0nxp0WjRjAXP2XFjNZxXXDBCkxthP+gApnoklTz50CRBWiEdEaSKu/nlZ+e1AiqnHDsc
	xHQApy9ETAbDbA+P9oQgEvU/GiksnrWUcKqHkXrbglraDK3iDUMRPsIW47Vx/I0051zNpczhzqG
	MZnVyTCCg0rgZPo5YOLBGGlqFopvag7BNWopxaUiAtdXRdPw==
X-Gm-Gg: ASbGncsPK88GiBh/F6JrlMPWZAJSdp3zeYnyrbpL11Ot8B9ayshYzTLsPkhCMLwEuTK
	4lyt4lfyXuz6prIyiZzxpUKE/8mLZfNl+8UVkcAIFjyEQsg59Orcswq1gkQE2o78tcyjIu3T1RT
	pf6P7GpiN04qwXcd8lJS8fTqWLYxYcUj5uJtZeRJmbVdVyYF/3JK4/Do76Giwes2zJCs3ry50p6
	wXPUDuAp0Y77srSD4qI5X6WhIEgYoaqP4rcWuOnJXOWqMjrKlHOijSeZiwpsm4OY6FoE5vaGQa/
	DwGfVy4deVHRVflxBNoC9/GmzqASJCyNl8ndshnM
X-Received: by 2002:a5d:5f81:0:b0:3b8:f2f2:e417 with SMTP id ffacd0b85a97d-3c5dcdfc643mr12585452f8f.51.1756220212757;
        Tue, 26 Aug 2025 07:56:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfNNAxRlCTk0NrFNcXanpZGLfhxaXD+arA2Yv+OzClLehDO9h3sSyj/t3pZGIHCSS6LqLgyA==
X-Received: by 2002:a5d:5f81:0:b0:3b8:f2f2:e417 with SMTP id ffacd0b85a97d-3c5dcdfc643mr12585436f8f.51.1756220212340;
        Tue, 26 Aug 2025 07:56:52 -0700 (PDT)
Received: from redhat.com ([185.137.39.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cbd534656asm1928657f8f.66.2025.08.26.07.56.51
        for <virtio-dev@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 07:56:51 -0700 (PDT)
Sender: Michael Tsirkin <mtsirkin@redhat.com>
From: "Michael S. Tsirkin" <mst@redhat.com>
X-Google-Original-From: "Michael S. Tsirkin" <mtsi.rki.n@redhat.com>
Date: Tue, 26 Aug 2025 10:56:49 -0400
To: virtio-dev@lists.linux.dev
Subject: test2082025
Message-ID: <20250826105621-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Qq_73AHZmPhtfqI2ui-atI9ysdGRiKKiWCIRWntWFDE_1756220213
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

pls ignore

