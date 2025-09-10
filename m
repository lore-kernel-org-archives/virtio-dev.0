Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1020A31D39A
	for <virtio-dev@lists.linux.dev>; Wed, 10 Sep 2025 09:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757497390; cv=none; b=DMZ2agktvHAxpmFJwcpwFlfpogBiVHDIJuIac8qblWxgBgdTOPVOVT7ZcOfypRbnIxeZdOJ6MnVmWOVMiLk8Qteqg5LMa8gj+ih/fO6eblM5HYTVCEsRRFfUgJAkgxha4SfDeA8czsWFzBanxhp9/3RqBxXctokM5lC7JrWETa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757497390; c=relaxed/simple;
	bh=8u6FaARRtSREzbYeC4zN0fjp2DwVky7Eafbhh1jrDCA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ParOLilVH3TQbfQuqbIwmbm8fx4Hwc3A1kicDz5Pp49xxSvsDIvsukA0WzRe6c+CsWv5mX3vzeCPueU9cEruWiqYCBYu38oqhfpJdqJp8R4Mzs+ueq4TyVFMB0m2ab+/sVc9N/dFk4Maxc5Sv0xO7BFuAH6R5q/hwDKHP97blEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q7ylun4+; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q7ylun4+"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b0418f6fc27so1085435266b.3
        for <virtio-dev@lists.linux.dev>; Wed, 10 Sep 2025 02:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757497386; x=1758102186; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8u6FaARRtSREzbYeC4zN0fjp2DwVky7Eafbhh1jrDCA=;
        b=q7ylun4+jKwo/zUpJmyVG1XFvDPVYnqeGa0S61X5EnITeroOgrwL6VOgp6VKwxe+5j
         OceMB7SsFinHXp1IittSXEsl/oBpNFAwyzzpiXZlpCM6MFXdGPbsHr7UCDQHtszhsxSK
         q4lyEovNpo4IV2vVawpQSDvC4g6UoxZes0RbMtsajawiIITzirIlqiAfkRu/Rk1G1n7D
         dI5gZt/hJJYqGOvSW3DuMHy1yL2wFSMfI5nEDMu+jAB9nMsjJaU8/cF4n/AlirpaCBSs
         7v/btEONlm92sqt5pup+FJ6DNY9owYDOTB40YVoThl3JVRQgicewQ7J45bCn6vDiEgbC
         wgpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757497386; x=1758102186;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8u6FaARRtSREzbYeC4zN0fjp2DwVky7Eafbhh1jrDCA=;
        b=ZzIHINDCX7VawhHE8jnrUJcEctT08MNxsypw4GDvoRU29z/cZI9K7z1OxGkou/OVfF
         IoHYjNPiJ1D0bajvBHOkPbnl+68g1+KQGID/mKpH21VmoKBtJJLwXqWEotDMxnrOxUAN
         1aeggtzO2F3pwm+kPKIuo+GHlGOh6iQAkGju0y9rZ0y6Nh+iD62I3HxhZf7frD7ZiC0W
         HCb5fTMzD/phHa9p705fMY+Nts1hqTQWZnHXu7vKmhapR8nYT/u/06bwV8jG3u+swuCx
         jFFcqsdRYLGC4WOS+fu220fAFoVbCscXN97+mZx0xVRc3GvRSDKTQrGdkUC6JtxKpU6X
         17oQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvgSvfXxUlGTFdAQPflJHffZCT3SyWtv+nlt1k0JECgIgoB5Xgmbms55jIWXOiihHRaaWktWgEFRCV@lists.linux.dev
X-Gm-Message-State: AOJu0Yx47R4afE3fGq/s0Utr59WooIgzjMh3+h0JMeC6pbJuHErm+UWf
	0kQ+1jOOK5prnsN72Q2P/47WR1IY1L0xc38n5LLUyZK7MAq0TY3WAAKpl2i5YMUFdis=
X-Gm-Gg: ASbGnct4fqhajQUI4+kR9DCQazQcFBS4prj//FYe8hoPX89Jnv8ofK4FYGACNVopsUK
	m3erXXxRHHooBkEwUOl/RbIh/H65pql5v6wYBqWyXZg5lpgXpDZ+1fr+bJXolLSCj0Zxl9UnOWd
	y8ZNwhKtKhUhmDADmfCZml6gWk+8IaOyVELqS/5ahCuTDa0CSlrCamEN5Ug8Ehz/0dxjira7Mfx
	6C4UYqByvOsVv6CIZQTWlRbgoK3NZBVNLcfJDq2omK7TocMLN+lYuiTs1RtB0v0scQVXqM3Z2Lj
	lGMV5Wn/E4korXRV21WJ3gihH8uIwR86BAW4MEjjqOyraRMKCl5i5hfbHeLVKo0VeB611rV/nra
	D3IYfOeKpnA7vp0EVZ+ecOqk=
X-Google-Smtp-Source: AGHT+IFWuLSyNubOEP+haT1kxcJlsnbQvIZV9vTCdS/TLhc04cY3/upnJwzgMXGylHLDI8GWpEssXw==
X-Received: by 2002:a17:907:7f93:b0:afe:764d:6b22 with SMTP id a640c23a62f3a-b04b145f591mr1268961666b.9.1757497386292;
        Wed, 10 Sep 2025 02:43:06 -0700 (PDT)
Received: from draig.lan ([185.126.160.19])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07830bb83bsm136246666b.42.2025.09.10.02.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 02:43:05 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id BC8215F82D;
	Wed, 10 Sep 2025 10:43:04 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Haixu Cui <quic_haixcui@quicinc.com>
Cc: <andriy.shevchenko@intel.com>,  <harald.mommer@oss.qualcomm.com>,
  <quic_msavaliy@quicinc.com>,  <broonie@kernel.org>,
  <virtio-dev@lists.linux.dev>,  <viresh.kumar@linaro.org>,
  <linux-spi@vger.kernel.org>,  <linux-kernel@vger.kernel.org>,
  <hdanton@sina.com>,  <qiang4.zhang@linux.intel.com>,
  <quic_ztu@quicinc.com>,  <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH v9 2/3] virtio-spi: Add virtio-spi.h
In-Reply-To: <20250828093451.2401448-3-quic_haixcui@quicinc.com> (Haixu Cui's
	message of "Thu, 28 Aug 2025 17:34:50 +0800")
References: <20250828093451.2401448-1-quic_haixcui@quicinc.com>
	<20250828093451.2401448-3-quic_haixcui@quicinc.com>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Wed, 10 Sep 2025 10:43:04 +0100
Message-ID: <87qzwe63tj.fsf@draig.linaro.org>
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Haixu Cui <quic_haixcui@quicinc.com> writes:

> Add virtio-spi.h header for virtio SPI.
>
> Signed-off-by: Haixu Cui <quic_haixcui@quicinc.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro
