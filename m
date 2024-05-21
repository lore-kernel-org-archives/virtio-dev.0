Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19604CE04
	for <virtio-dev@lists.linux.dev>; Tue, 21 May 2024 06:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716273865; cv=none; b=B6CVb/KbXB98C/uSHdbESyiz4qQ9FpAprs8/K+ySv8BYKmUgLevJzQIpZjwVrFWKmZOq0jMJBVaksQbXp6Pyotz9V/9AS/7TKa8QQ1lZJ+nLuKr7sjoMnkMUXNRkU9sq8DTGOumKPs6mR0UVh/zmRdGbX6MKltdYWMkcgRu8sRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716273865; c=relaxed/simple;
	bh=ItsQc36XRpl0PlIK2GYXtbbS4kcWyzx+uQSrvybA7uI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZU2s80lLJbNB7wCS0Wuu3oBnmlULYFD0KdVo2DyVObJ+L20bpiZsDpWF/CD31aqoCTuZ5w6t8kHIjhZOt7qkwKKJvGpkpk0JfO+xshKFC50atMyiGvB1pB3j1OmGxCwdB1Sl5JChdAwRQa9yL5pyWHz2spvrPL5LI2viWU7hROE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=l7vCtU6t; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l7vCtU6t"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1ee954e0aa6so68927715ad.3
        for <virtio-dev@lists.linux.dev>; Mon, 20 May 2024 23:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716273863; x=1716878663; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zZJHVvCDSGmfhT+sZ8gumFaCEHqxakUpTmREJbvnKqM=;
        b=l7vCtU6tbkCGi4Mf7BUsMjgCmuCg5pePOoPLjTAuYgCaOWqzypK7x07c/R97YUx+kJ
         wuQ/aAVXreKqIj/BTORNxXBQx/cS+cW+yB22GP1KeqgeUgWx4qSS2y1RkcLm9eyhvCmr
         Y9LU4iFRHavpn/eoE15vsgWZF+ZqF6+kQb/mGwNGhl65/+5hMgFg0H3Zv7RtCoNFrXSS
         FDycNSBF3ZVMZxQBE44QpZ7JC/qNBdYMcIrpTRfpw0GB4EWH1lIfDor/Z8ag1wOUla3V
         q9luverDTwl0HYUC2yp3jop1hgAvYqHeJFBXQVFCT4ydIjHz3Sx946kmdh0S1qzEOou1
         MLKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716273863; x=1716878663;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zZJHVvCDSGmfhT+sZ8gumFaCEHqxakUpTmREJbvnKqM=;
        b=c8NtSF5xYzfTzw8olOuq5IZiqwrYve8vrGzyaqyoWDZVtC8TmnwUu5MYQxI6/0iPC5
         7ZL93R3lfMxnKdTZCQUDsQIK4F9pxI75//VxkbjdznLjU/oWk6HqaUvWOcgImjt1m6wp
         9goPo4yxgKNnU51JUuIIKOfM4Rsi4na+YRrjy7hGOMnJ/qdk1LT0pTw0LbPHu8cZUVIl
         DtScQpHvywMlNmWOLlctrAStvVB0cFEqkoNmoUAKKTXCQujJCT6dcc1lj0afVTfGJPbb
         tcriTtFAFRrU0ZOJjjraazjqSk4CyxS8A4N4vBPwlttCff295jMJKABYozxG/N/CBQkP
         OKhw==
X-Forwarded-Encrypted: i=1; AJvYcCUOmZqFE/dHvs+JT2CIsaIEruVYPHrf0VYiRURCqoAqMb+GAS4RBJBaosiKoFo3cdzMbcW4dsRNY/1xjYa86NxPxbfOegh4FwmhWw==
X-Gm-Message-State: AOJu0YzL7PGsmcjMBXpowMicG2j2G3uIcAyX1HEgKnpVL0ciL/Tom3EF
	g6POCifr8BHwcg71fiPgqBeOivhaG8bftISFnvV38Q/hclvlSl3XvlNo6JJ6Phw=
X-Google-Smtp-Source: AGHT+IFTZTsBVMijqj7bO9HzwK1/QSYtZpEodjF0qHprZiH1/aUgxMe046EbGrCKbsn0zUcuJrFYAg==
X-Received: by 2002:a17:902:9a0a:b0:1e2:9aa7:fd21 with SMTP id d9443c01a7336-1ef4416150cmr269824585ad.54.1716273862942;
        Mon, 20 May 2024 23:44:22 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f2f387318bsm47786715ad.189.2024.05.20.23.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 23:44:22 -0700 (PDT)
Date: Tue, 21 May 2024 12:14:20 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>,
	"virtio-comment@lists.linux.dev" <virtio-comment@lists.linux.dev>,
	"virtio-dev@lists.linux.dev" <virtio-dev@lists.linux.dev>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
	"stratos-dev@op-lists.linaro.org" <stratos-dev@op-lists.linaro.org>,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH V3 Resend] virtio-transport: Clarify requirements
Message-ID: <20240521064420.35t7vaavzduwm7q4@vireshk-i7>
References: <3543c631e29d35a667ca9d9e912d1a6db1feb0ce.1716197180.git.viresh.kumar@linaro.org>
 <PH0PR12MB54815E4558E7577AC219F5F9DCE92@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20240520082400-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240520082400-mutt-send-email-mst@kernel.org>

On 20-05-24, 08:25, Michael S. Tsirkin wrote:
> Well we say "do not do this" in the list subscription form.
> Viresh, what gives?

Apologies. I didn't read the page properly.

-- 
viresh
