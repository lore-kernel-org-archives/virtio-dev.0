Return-Path: <virtio-dev-return-9959-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E3796986451
	for <virtio-dev@lists.oasis-open.org>; Tue, 20 Sep 2022 13:40:34 +0000 (UTC)
Message-ID: <ec26cf9e-5436-2d61-45c3-6d3925706d14@nvidia.com>
Date: Tue, 20 Sep 2022 21:40:16 +0800
References: <20220901021038.84751-1-gavinl@nvidia.com>
 <76fca691-aff5-ad9e-6228-0377e2890a05@nvidia.com>
 <20220919083552.60449589@kernel.org>
From: Gavin Li <gavinl@nvidia.com>
In-Reply-To: <20220919083552.60449589@kernel.org>
MIME-Version: 1.0
Subject: Re: [virtio-dev] [PATCH v5 0/2] Improve virtio performance for 9k mtu
Content-Type: multipart/alternative;
 boundary="------------GcEE0q0gFxmPAxV43W0hbBme"
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: stephen@networkplumber.org, davem@davemloft.net, jesse.brandeburg@intel.com, alexander.h.duyck@intel.com, sridhar.samudrala@intel.com, jasowang@redhat.com, loseweigh@gmail.com, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, gavi@nvidia.com, parav@nvidia.com
List-ID: <virtio-dev.lists.oasis-open.org>

--------------GcEE0q0gFxmPAxV43W0hbBme
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/19/2022 11:35 PM, Jakub Kicinski wrote:
> External email: Use caution opening links or attachments
>
>
> On Wed, 7 Sep 2022 10:57:01 +0800 Gavin Li wrote:
>> Hi Dave/Jakub, Michael,
>>
>> Sorry for the previous email formatting.
>> Should this 2-patch series merge through virtio tree or netdev tree?
> netdev seems appropriate, sorry for the delay

v6 is posted at 
linkhttps://lore.kernel.org/netdev/20220914144911.56422-1-gavinl@nvidia.com/

Would you please review it?

--------------GcEE0q0gFxmPAxV43W0hbBme
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<html><head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dutf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class=3D"moz-cite-prefix">On 9/19/2022 11:35 PM, Jakub Kicinski
      wrote:<br>
    </div>
    <blockquote type=3D"cite" cite=3D"mid:20220919083552.60449589@kernel.or=
g">
      <pre class=3D"moz-quote-pre" wrap=3D"">External email: Use caution op=
ening links or attachments


On Wed, 7 Sep 2022 10:57:01 +0800 Gavin Li wrote:
</pre>
      <blockquote type=3D"cite">
        <pre class=3D"moz-quote-pre" wrap=3D"">Hi Dave/Jakub, Michael,

Sorry for the previous email formatting.
Should this 2-patch series merge through virtio tree or netdev tree?
</pre>
      </blockquote>
      <pre class=3D"moz-quote-pre" wrap=3D"">
netdev seems appropriate, sorry for the delay</pre>
    </blockquote>
    <p><span style=3D"color: rgb(255, 255, 255); font-family:
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
        !important; float: none;">v6 is posted at link<span>&nbsp;</span></=
span><a aria-label=3D"Link
https://lore.kernel.org/netdev/20220914144911.56422-1-gavinl@nvidia.com/" t=
itle=3D"https://lore.kernel.org/netdev/20220914144911.56422-1-gavinl@nvidia=
.com/" href=3D"https://lore.kernel.org/netdev/20220914144911.56422-1-gavinl=
@nvidia.com/" rel=3D"noopener noreferrer" target=3D"_blank" tabindex=3D"-1"=
 style=3D"-webkit-font-smoothing: antialiased; box-sizing:
        border-box; background-color: rgb(41, 41, 41); outline-style:
        none; color: rgb(127, 133, 245); text-decoration: none;
        font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe
        UI&quot;, system-ui, &quot;Apple Color Emoji&quot;, &quot;Segoe
        UI Emoji&quot;, &quot;Segoe UI Web&quot;, sans-serif; font-size:
        14px; font-style: normal; font-variant-ligatures: normal;
        font-variant-caps: normal; font-weight: 400; letter-spacing:
        normal; orphans: 2; text-align: start; text-indent: 0px;
        text-transform: none; white-space: normal; widows: 2;
        word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D"moz-tx=
t-link-freetext">https://lore.kernel.org/netdev/20220914144911.56422-1-gavi=
nl@nvidia.com/</a></p>
    <p>Would you please review it?<br>
    </p>
    <blockquote type=3D"cite" cite=3D"mid:20220919083552.60449589@kernel.or=
g">
      <pre class=3D"moz-quote-pre" wrap=3D"">
</pre>
    </blockquote>
  </body>
</html>

--------------GcEE0q0gFxmPAxV43W0hbBme--

