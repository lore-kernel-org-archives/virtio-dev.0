Return-Path: <virtio-dev-return-13956-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6B72E8181F
	for <virtio-dev@archiver.kernel.org>; Tue, 26 Sep 2023 06:00:17 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 1E6617BB0C
	for <virtio-dev@archiver.kernel.org>; Tue, 26 Sep 2023 06:00:17 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 133A5986422
	for <virtio-dev@archiver.kernel.org>; Tue, 26 Sep 2023 06:00:17 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 04CC99863A9; Tue, 26 Sep 2023 06:00:17 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E144A98639D
	for <virtio-dev@lists.oasis-open.org>; Tue, 26 Sep 2023 06:00:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695708010; x=1696312810;
        h=in-reply-to:from:content-language:subject:references:cc:to
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0E0zTKMEfwKu3bsEeTFDmP2cvslgKY5E3froFtAqil4=;
        b=b4M7MEoZRwqe1g9ttOtc4FWPli4eatTWTF/FR0AoLFglJtnBO7rN1lgyGE55ZpuzYN
         /6mWFT63PYVxS3E11XNmfiOxaOYmwzLEY2rwUVm48KpmJ6co9RdfCIfcHW7toBH34ywl
         kEOLL1lB/UCCWZqeJP9BwOrmVlhfLl7/rfMejqwv0QsPhhmX1VYMXn5NuJvz/tn99VPS
         Fr8BnnHHa2rhvw1hYTTeENRCnwn3soSVRYYTrgI4zvjzRrnuJubkBbxRmXnYS2ASOt+h
         qsV2ftaJ6u4I71D+UX7s9NgF1V49GH8EwBQ79jTPw4WB+98fbjXW4gb2k2pcQIb/VTU2
         WUtw==
X-Gm-Message-State: AOJu0Ywg3umYNyLtEAFRhYBrPVtYxs/u1clKqDAiEwkmRg7hD3OhCTPh
	izwyK3i69Jp5WGDl/PrLHPEWbw==
X-Google-Smtp-Source: AGHT+IGj9gM+Xtdx8jAigNh8UutsXKgUR8CDr0WY/dajvDIY+8dpzyAaNsK/W5zZB4DLAW69wzuhVg==
X-Received: by 2002:a05:6a20:12d6:b0:14c:c393:692 with SMTP id v22-20020a056a2012d600b0014cc3930692mr9920701pzg.7.1695708010184;
        Mon, 25 Sep 2023 23:00:10 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------zKaNayW4i66PXFs34PnbTs0P"
Message-ID: <904049f9-3ddf-7e88-c6f3-785a29a08210@linaro.org>
Date: Tue, 26 Sep 2023 08:00:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
To: jeshwanthkumar.nk@amd.com
Cc: Devaraj.Rangasamy@amd.com, Mythri.Pandeshwarakrishna@amd.com,
 Nimesh.Easow@amd.com, Rijo-john.Thomas@amd.com, babulu.ellune@amd.com,
 virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org,
 jens.wiklander@linaro.org
References: <80a2e4337affb043909c348395fb45aeeb693dc7.1695640593.git.JESHWANTHKUMAR.NK@amd.com>
Content-Language: en-US
From: Sumit Garg <sumit.garg@linaro.org>
In-Reply-To: <80a2e4337affb043909c348395fb45aeeb693dc7.1695640593.git.JESHWANTHKUMAR.NK@amd.com>
Subject: Re: [virtio-dev] [PATCH v2] virtio-tee: Reserve device ID 46 for TEE
 device

--------------zKaNayW4i66PXFs34PnbTs0P
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

+cc Jens

> In a virtual environment, an application running in guest VM may want
> to delegate security sensitive tasks to a Trusted Application (TA)
> running within a Trusted Execution Environment (TEE). A TEE is a trusted
> OS running in some secure environment, for example, TrustZone on ARM
> CPUs, or a separate secure co-processor etc.

I have been exploring this area quite recently with an effort to have a common VIRIO interface which can support different trusted OS implementations. I guess you intend to test it with AMD-TEE, right? Any plans to test it with OP-TEE? As currently we have these two supported upstream.

Do you currently have any virtio frontend/backend implementations for this?

> 
> A virtual TEE device emulates a TEE within a guest VM. Such a virtual
> TEE device supports multiple operations such as:
> 
> VIRTIO_TEE_CMD_OPEN_DEVICE – Open a communication channel with virtio
>                              TEE device.
> VIRTIO_TEE_CMD_CLOSE_DEVICE – Close communication channel with virtio
>                               TEE device.
> VIRTIO_TEE_CMD_GET_VERSION – Get version of virtio TEE.
> VIRTIO_TEE_CMD_OPEN_SESSION – Open a session to communicate with
>                               trusted application running in TEE.
> VIRTIO_TEE_CMD_CLOSE_SESSION – Close a session to end communication
>                                with trusted application running in TEE.
> VIRTIO_TEE_CMD_INVOKE_FUNC – Invoke a command or function in trusted
>                              application running in TEE.
> VIRTIO_TEE_CMD_CANCEL_REQ – Cancel an ongoing command within TEE.
> 

How about shared memory support? We would like to register guest pages with the trusted OS.

-Sumit

> We would like to reserve device ID 46 for Virtio-TEE device.
> 
> Signed-off-by: Jeshwanth Kumar <jeshwanthkumar.nk@amd.com>
> ---
>  content.tex  <https://lore.kernel.org/all/80a2e4337affb043909c348395fb45aeeb693dc7.1695640593.git.JESHWANTHKUMAR.NK@amd.com/#Z31content.tex>  | 2 ++
>  1 file changed  <https://lore.kernel.org/all/80a2e4337affb043909c348395fb45aeeb693dc7.1695640593.git.JESHWANTHKUMAR.NK@amd.com/#related>, 2 insertions(+)
> 
> diff 
<https://lore.kernel.org/all/80a2e4337affb043909c348395fb45aeeb693dc7.1695640593.git.JESHWANTHKUMAR.NK@amd.com/#iZ31content.tex> 
--git a/content.tex b/content.tex > index 0a62dce..644aa4a 100644 > --- 
a/content.tex > +++ b/content.tex > @@ -739,6 +739,8 @@ \chapter{Device 
Types}\label{sec:Device Types} >  \hline
>  45         &   SPI master \\
>  \hline
> +46         &   TEE device \\  > +\hline > \end{tabular}
> 
>  Some of the devices above are unspecified by this document,

--------------zKaNayW4i66PXFs34PnbTs0P
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <pre id="b" style="font-size: 13px; font-family: monospace; background: rgb(255, 255, 255); color: rgb(0, 0, 51); white-space: pre-wrap; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">+cc Jens

&gt; In a virtual environment, an application running in guest VM may want
&gt; to delegate security sensitive tasks to a Trusted Application (TA)
&gt; running within a Trusted Execution Environment (TEE). A TEE is a trusted
&gt; OS running in some secure environment, for example, TrustZone on ARM
&gt; CPUs, or a separate secure co-processor etc.

I have been exploring this area quite recently with an effort to have a common VIRIO interface which can support different trusted OS implementations. I guess you intend to test it with AMD-TEE, right? Any plans to test it with OP-TEE? As currently we have these two supported upstream.

Do you currently have any virtio frontend/backend implementations for this?

&gt; 
&gt; A virtual TEE device emulates a TEE within a guest VM. Such a virtual
&gt; TEE device supports multiple operations such as:
&gt; 
&gt; VIRTIO_TEE_CMD_OPEN_DEVICE – Open a communication channel with virtio
&gt;                              TEE device.
&gt; VIRTIO_TEE_CMD_CLOSE_DEVICE – Close communication channel with virtio
&gt;                               TEE device.
&gt; VIRTIO_TEE_CMD_GET_VERSION – Get version of virtio TEE.
&gt; VIRTIO_TEE_CMD_OPEN_SESSION – Open a session to communicate with
&gt;                               trusted application running in TEE.
&gt; VIRTIO_TEE_CMD_CLOSE_SESSION – Close a session to end communication
&gt;                                with trusted application running in TEE.
&gt; VIRTIO_TEE_CMD_INVOKE_FUNC – Invoke a command or function in trusted
&gt;                              application running in TEE.
&gt; VIRTIO_TEE_CMD_CANCEL_REQ – Cancel an ongoing command within TEE.
&gt; 

How about shared memory support? We would like to register guest pages with the trusted OS.

-Sumit

&gt; We would like to reserve device ID 46 for Virtio-TEE device.
&gt; 
&gt; Signed-off-by: Jeshwanth Kumar <a class="moz-txt-link-rfc2396E" href="mailto:jeshwanthkumar.nk@amd.com">&lt;jeshwanthkumar.nk@amd.com&gt;</a>
&gt; ---
&gt;  <a id="iZ31content.tex" href="https://lore.kernel.org/all/80a2e4337affb043909c348395fb45aeeb693dc7.1695640593.git.JESHWANTHKUMAR.NK@amd.com/#Z31content.tex" style="font-size: 13px; font-family: monospace; background: rgb(255, 255, 255); color: rgb(0, 0, 255); text-decoration: none;">content.tex</a> | 2 ++
&gt;  1 file <a href="https://lore.kernel.org/all/80a2e4337affb043909c348395fb45aeeb693dc7.1695640593.git.JESHWANTHKUMAR.NK@amd.com/#related" style="font-size: 13px; font-family: monospace; background: rgb(255, 255, 255); color: rgb(0, 0, 255); text-decoration: none;">changed</a>, 2 insertions(+)
&gt; 
<span class="head" style="font-size: 13px; font-family: monospace; background: rgb(255, 255, 255); color: rgb(0, 0, 0);"><a href="https://lore.kernel.org/all/80a2e4337affb043909c348395fb45aeeb693dc7.1695640593.git.JESHWANTHKUMAR.NK@amd.com/#iZ31content.tex" id="Z31content.tex" style="font-size: 13px; font-family: monospace; background: rgb(255, 255, 255); color: rgb(0, 0, 255); text-decoration: none;">&gt; diff</a> --git a/content.tex b/content.tex
</span><span class="head" style="font-size: 13px; font-family: monospace; background: rgb(255, 255, 255); color: rgb(0, 0, 0);">&gt; index 0a62dce..644aa4a 100644
</span><span class="head" style="font-size: 13px; font-family: monospace; background: rgb(255, 255, 255); color: rgb(0, 0, 0);">&gt; --- a/content.tex
</span><span class="head" style="font-size: 13px; font-family: monospace; background: rgb(255, 255, 255); color: rgb(0, 0, 0);">&gt; +++ b/content.tex
</span><span class="hunk" style="font-size: 13px; font-family: monospace; background: rgb(255, 255, 255); color: rgb(153, 102, 0);">&gt; @@ -739,6 +739,8 @@ \chapter{Device Types}\label{sec:Device Types}
</span>&gt;  \hline
&gt;  45         &amp;   SPI master \\
&gt;  \hline
<span class="add" style="font-size: 13px; font-family: monospace; background: rgb(255, 255, 255); color: rgb(0, 102, 0);">&gt; +46         &amp;   TEE device \\
</span><span class="add" style="font-size: 13px; font-family: monospace; background: rgb(255, 255, 255); color: rgb(0, 102, 0);">&gt; +\hline
</span>&gt; \end{tabular}
&gt; 
&gt;  Some of the devices above are unspecified by this document,</pre>
    <p></p>
  </body>
</html>

--------------zKaNayW4i66PXFs34PnbTs0P--
