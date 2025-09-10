Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115C53148B5
	for <virtio-dev@lists.linux.dev>; Wed, 10 Sep 2025 09:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757497184; cv=none; b=U4jMgmcA3fK9JfQG/rrukyQPu7H9IB4xPkwQGN+/RSaaobHNUawffYIBDfocXCor7AnbmMhEWMxED45MnR3PG4n1BXaw/wcR+wYlN2kNv8zVBAKJmMrn9FOuFPiGC4zx3NCsHfxS3Hkyl6/OlYGOWuufAdU+Zr0njNnChmrOiY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757497184; c=relaxed/simple;
	bh=m3w9198KPcW52Kq5czGxwlCuVIFnmkUpH3jecGwOHRI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dpDERYJnAcaaxAC+vX9n0EbJ4WKjyxKttQJdjlNBCPCI0zV9Ysk5onZThxE6wWClCU+fzE4T0UWdVdGlYAbVcggE9cHX/0lFgyCVnuU3CNRWj40Fpds/P9cvBU27rbwgtSVEEUtbP3S1U11QO2EKqG00ER1TI2dV2VF68KE63Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UmOM3FOd; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UmOM3FOd"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b042eb09948so1269684266b.3
        for <virtio-dev@lists.linux.dev>; Wed, 10 Sep 2025 02:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757497180; x=1758101980; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m3w9198KPcW52Kq5czGxwlCuVIFnmkUpH3jecGwOHRI=;
        b=UmOM3FOdGVSvOkqrHnBWojXyFHayp5qEXCveu39F7LZcela0lLRCQzhFxfLfvlHhxx
         CogNK2fOygdeHfcxEpbvDTy2S1kksQQxmPz1Kdzf72JEM09LK1NinU5ku/YvLXQarELQ
         UEsVCJUDrD+mE47gReQqmHKyOANLCDdAnR6gUb3SuIyx7pbXJ+/i7BHiC9XgSnqmlchQ
         jom9q/66k2GoUSlcGpa8PqV4adTBXAvps3apMn8haiFfhnibwkRZsvZBvKHXb1OPVCn+
         uua5amZcI1jfLCivAfafNQCJsFknNR9B2zoIVLOZr/boiFBvMjdTwmPmmwT6RdKoMoK/
         3OYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757497180; x=1758101980;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m3w9198KPcW52Kq5czGxwlCuVIFnmkUpH3jecGwOHRI=;
        b=UF7w4KLDNQLvPJTA5UplE7ks7unER/RSFkBRAznKF4KVYS+GPFZm43gp+9OKHHC77N
         eLq9y75bcJTD0coDF7WQS00vYqxwcy/pKernJavHyn0BJvA1y7WMDP+Sqm43wdVW9o0r
         ykWNmU8PnAPx3D4Pcjpo2aSNu5+Z+Q4+RaxtLA2FTWpMpAMrh5B6BRzicGrLUEg2OAiR
         nySuPsAMj13a8tuTI4bSFsdv1h6+hnP25/D86cWfCPykUHhSiVLiYr8MEaxBQ/cbtSAa
         QaNkWQVV7pd/jg9MWogvTiurMXKBQpvhhk1J4hX3WGcmhJtmyAAmwTePJOkoK3xffWCf
         JmXA==
X-Forwarded-Encrypted: i=1; AJvYcCVsJRyrt9i9t8SchUz3z29VEGAwnfU2OLD9AHSvC4aR8FuH4KyWTZXmKjstMPdzir23VlWXxYwVPv97@lists.linux.dev
X-Gm-Message-State: AOJu0Yw1XrNEha956O187hWIFvsQZ1k6k2jlxLHIgNOtmzy5933PkQoe
	9171sV8aA6Gkgt56q+L73PbPQ6eKlft06CPzPYU525uxHxDfm0ydNJneHS2EsP/pJM0=
X-Gm-Gg: ASbGncue9c/qHOQVIHRd8bPigqFxfIzLwktj1XMnIpCAma0+T2VvVnRTf5s2g8VP4/c
	82pYVB/0Ef+n0H9iyIMusJ02uzzC965faDgcoY2X+FaOdoRdebg55dRqgfRfyC8AjDqzrrk17Aw
	ArcKgdh+qR2F6n1GURrDGVnZm7C2J3KcOvlmKKu7DRQNMVoF5WOqCD2MX6/pFPkEN9foJ+51s4G
	j/EvWv2gFEAiU6o7yorgveGh6HFM4EqhvNqAR4kXSYMetttfyOi9AisaKpHBFYimCuJ0g2Ud9NL
	3Dyd+IO7S0074UXKqYQp3/u7+j015kfba+8+EnQDBbaPbloNwuhr7ooWFlQao6U1sT8uhXtPREl
	5H//um8B7JPbEhChl4AydOcAWv1g7Is2Fxg==
X-Google-Smtp-Source: AGHT+IEgLz62atvGYTtgWhK0IqE5DaeMbopSvx9UyamfacYq3cpWns33qwgJoigjRNFokWLtUFrPnA==
X-Received: by 2002:a17:907:97c9:b0:b04:1a1c:cb5b with SMTP id a640c23a62f3a-b04b13fd491mr1455086066b.7.1757497180392;
        Wed, 10 Sep 2025 02:39:40 -0700 (PDT)
Received: from draig.lan ([185.126.160.19])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07833ac0c1sm138008066b.84.2025.09.10.02.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 02:39:39 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id BCED35F82D;
	Wed, 10 Sep 2025 10:39:38 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Haixu Cui <quic_haixcui@quicinc.com>
Cc: <andriy.shevchenko@intel.com>,  <harald.mommer@oss.qualcomm.com>,
  <quic_msavaliy@quicinc.com>,  <broonie@kernel.org>,
  <virtio-dev@lists.linux.dev>,  <viresh.kumar@linaro.org>,
  <linux-spi@vger.kernel.org>,  <linux-kernel@vger.kernel.org>,
  <hdanton@sina.com>,  <qiang4.zhang@linux.intel.com>,
  <quic_ztu@quicinc.com>,  <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH v9 1/3] virtio: Add ID for virtio SPI
In-Reply-To: <20250828093451.2401448-2-quic_haixcui@quicinc.com> (Haixu Cui's
	message of "Thu, 28 Aug 2025 17:34:49 +0800")
References: <20250828093451.2401448-1-quic_haixcui@quicinc.com>
	<20250828093451.2401448-2-quic_haixcui@quicinc.com>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Wed, 10 Sep 2025 10:39:38 +0100
Message-ID: <87wm6663z9.fsf@draig.linaro.org>
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Haixu Cui <quic_haixcui@quicinc.com> writes:

> Add VIRTIO_ID_SPI definition for virtio SPI.
>
> Signed-off-by: Haixu Cui <quic_haixcui@quicinc.com>
> Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro
