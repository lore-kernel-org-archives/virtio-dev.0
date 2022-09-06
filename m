Return-Path: <virtio-dev-return-9898-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9833B9863FE
	for <virtio-dev@lists.oasis-open.org>; Tue,  6 Sep 2022 13:51:13 +0000 (UTC)
Message-ID: <e6cf4afe-ded7-6890-08c6-fdf6ef2de477@nvidia.com>
Date: Tue, 6 Sep 2022 21:50:59 +0800
From: Gavin Li <gavinl@nvidia.com>
References: <20220901021038.84751-1-gavinl@nvidia.com>
In-Reply-To: <20220901021038.84751-1-gavinl@nvidia.com>
MIME-Version: 1.0
Subject: Re: [virtio-dev] [PATCH v5 0/2] Improve virtio performance for 9k mtu
Content-Type: multipart/alternative;
 boundary="------------Tg0pJ2wLEfAdy52TwHH6X8Ku"
Content-Language: en-US
To: stephen@networkplumber.org, davem@davemloft.net, jesse.brandeburg@intel.com, alexander.h.duyck@intel.com, kuba@kernel.org, sridhar.samudrala@intel.com, jasowang@redhat.com, loseweigh@gmail.com, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, mst@redhat.com
Cc: gavi@nvidia.com, parav@nvidia.com
List-ID: <virtio-dev.lists.oasis-open.org>

--------------Tg0pJ2wLEfAdy52TwHH6X8Ku
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Michael, Dave/Jakob, Can you please review these two patches? If they 
are OK, should it be merged through virtio tree or netdev tree?

On 9/1/2022 10:10 AM, Gavin Li wrote:
> External email: Use caution opening links or attachments
>
>
> This small series contains two patches that improves virtio netdevice
> performance for 9K mtu when GRO/ guest TSO is disabled.
>
> Gavin Li (2):
>    virtio-net: introduce and use helper function for guest gso support
>      checks
>    virtio-net: use mtu size as buffer length for big packets
>
>   drivers/net/virtio_net.c | 48 ++++++++++++++++++++++++++--------------
>   1 file changed, 32 insertions(+), 16 deletions(-)
>
> --
> 2.31.1
>
>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail:virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail:virtio-dev-help@lists.oasis-open.org
>
--------------Tg0pJ2wLEfAdy52TwHH6X8Ku
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><span style="color: rgb(255, 255, 255); font-family:
        -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;,
        system-ui, &quot;Apple Color Emoji&quot;, &quot;Segoe UI
        Emoji&quot;, &quot;Segoe UI Web&quot;, sans-serif; font-size:
        14px; font-style: normal; font-variant-ligatures: normal;
        font-variant-caps: normal; font-weight: 400; letter-spacing:
        normal; orphans: 2; text-align: start; text-indent: 0px;
        text-transform: none; white-space: normal; widows: 2;
        word-spacing: 0px; -webkit-text-stroke-width: 0px;
        background-color: rgb(41, 41, 41); text-decoration-style:
        initial; text-decoration-color: initial; display: inline
        !important; float: none;">Hi Michael, Dave/Jakob, Can you please
        review these two patches? If they are OK, should it be merged
        through virtio tree or netdev tree?</span></p>
    <div class="moz-cite-prefix">On 9/1/2022 10:10 AM, Gavin Li wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20220901021038.84751-1-gavinl@nvidia.com">
      <pre class="moz-quote-pre" wrap="">External email: Use caution opening links or attachments


This small series contains two patches that improves virtio netdevice
performance for 9K mtu when GRO/ guest TSO is disabled.

Gavin Li (2):
  virtio-net: introduce and use helper function for guest gso support
    checks
  virtio-net: use mtu size as buffer length for big packets

 drivers/net/virtio_net.c | 48 ++++++++++++++++++++++++++--------------
 1 file changed, 32 insertions(+), 16 deletions(-)

--
2.31.1


---------------------------------------------------------------------
To unsubscribe, e-mail: <a class="moz-txt-link-abbreviated" href="mailto:virtio-dev-unsubscribe@lists.oasis-open.org">virtio-dev-unsubscribe@lists.oasis-open.org</a>
For additional commands, e-mail: <a class="moz-txt-link-abbreviated" href="mailto:virtio-dev-help@lists.oasis-open.org">virtio-dev-help@lists.oasis-open.org</a>

</pre>
    </blockquote>
  </body>
</html>

--------------Tg0pJ2wLEfAdy52TwHH6X8Ku--

