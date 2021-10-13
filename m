Return-Path: <virtio-dev-return-8856-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 50A3698640D
	for <virtio-dev@lists.oasis-open.org>; Wed, 13 Oct 2021 04:07:13 +0000 (UTC)
References: <cover.1634037711.git.viresh.kumar@linaro.org>
 <325276eec77c6ab3bd28382386055b821754396b.1634037711.git.viresh.kumar@linaro.org>
 <CAK8P3a3GvrcjeTXfdnL=vrWSUVD2KOXa7x1Lw0+uMSzfOJarEQ@mail.gmail.com>
 <20211013033919.jybykoof526zjpsm@vireshk-i7>
From: Jie Deng <jie.deng@intel.com>
Message-ID: <457e947c-7c62-31e4-f879-61ff482297e6@intel.com>
Date: Wed, 13 Oct 2021 12:07:05 +0800
MIME-Version: 1.0
In-Reply-To: <20211013033919.jybykoof526zjpsm@vireshk-i7>
Subject: [virtio-dev] Re: [PATCH V5 2/2] virtio: i2c: Allow zero-length transactions
Content-Type: multipart/alternative;
 boundary="------------93878DC8647886ED0C432BEE"
Content-Language: en-US
To: Viresh Kumar <viresh.kumar@linaro.org>, Arnd Bergmann <arnd@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Wolfram Sang <wsa@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Jason Wang <jasowang@redhat.com>, Bill Mills <bill.mills@linaro.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, virtio-dev@lists.oasis-open.org, Stratos Mailing List <stratos-dev@op-lists.linaro.org>, Gerd Hoffmann <kraxel@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--------------93878DC8647886ED0C432BEE
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2021/10/13 11:39, Viresh Kumar wrote:
>
>>> @@ -124,13 +140,23 @@ \subsubsection{Device Operation: Operation Status}\label{sec:Device Types / I2C
>>>
>>>   \drivernormative{\subsubsection}{Device Operation}{Device Types / I2C Adapter Device / Device Operation}
>>>
>>> +A driver SHOULD implement the VIRTIO_I2C_F_ZERO_LENGTH_REQUEST feature.
>> I don't think this needs to be "SHOULD", as a driver may be written to only
>> talk to certain i2c clients on the device side, and they do not need zero
>> length requests. Maybe this could be
>>
>> "A driver MAY assume that the VIRTIO_I2C_F_ZERO_LENGTH_REQUEST
>> feature is available".
> The problem here is that "VIRTIO_I2C_FLAGS_M_RD" is supported only
> with VIRTIO_I2C_F_ZERO_LENGTH_REQUEST feature. If the feature isn't
> available, then the device/driver need to encode/decode the direction
> of the transfer (read/write) to/from the permissions of the buffer.


The "VIRTIO_I2C_FLAGS_M_RD" is consistent with the permissions of the 
buffer.

When this flag is set, the buffer is also marked as device write -only 
with VIRTQ_DESC_F_WRITE set.

So if this feature isn't available we can use the the latter. We only 
need this flag when there is no buffer.


--------------93878DC8647886ED0C432BEE
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2021/10/13 11:39, Viresh Kumar
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20211013033919.jybykoof526zjpsm@vireshk-i7"><br>
      <blockquote type="cite">
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">@@ -124,13 +140,23 @@ \subsubsection{Device Operation: Operation Status}\label{sec:Device Types / I2C

 \drivernormative{\subsubsection}{Device Operation}{Device Types / I2C Adapter Device / Device Operation}

+A driver SHOULD implement the VIRTIO_I2C_F_ZERO_LENGTH_REQUEST feature.
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">
I don't think this needs to be "SHOULD", as a driver may be written to only
talk to certain i2c clients on the device side, and they do not need zero
length requests. Maybe this could be

"A driver MAY assume that the VIRTIO_I2C_F_ZERO_LENGTH_REQUEST
feature is available".
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
The problem here is that "VIRTIO_I2C_FLAGS_M_RD" is supported only
with VIRTIO_I2C_F_ZERO_LENGTH_REQUEST feature. If the feature isn't
available, then the device/driver need to encode/decode the direction
of the transfer (read/write) to/from the permissions of the buffer.
</pre>
    </blockquote>
    <p><br>
    </p>
    <p>The "VIRTIO_I2C_FLAGS_M_RD" is consistent with the permissions of
      the buffer.<br>
    </p>
    <p>When this flag is set, the buffer is also marked <span
        class="fontstyle0">as device write -only with </span><span
        class="fontstyle0">VIRTQ_DESC_F_WRITE set.</span></p>
    <p><span class="fontstyle0">So if this feature isn't available we
        can use the the latter. We only need this flag when there is no
        buffer.</span><br style=" font-style: normal; font-variant:
        normal; font-weight: normal; letter-spacing: normal;
        line-height: normal; orphans: 2; text-align: -webkit-auto;
        text-indent: 0px; text-transform: none; white-space: normal;
        widows: 2; word-spacing: 0px; -webkit-text-size-adjust: auto;
        -webkit-text-stroke-width: 0px; ">
    </p>
  </body>
</html>

--------------93878DC8647886ED0C432BEE--

