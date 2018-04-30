Return-Path: virtio-dev-return-4008-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 55396581810F
	for <virtio-dev@lists.oasis-open.org>; Sun, 29 Apr 2018 19:47:16 -0700 (PDT)
From: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
References: <1524848820-42258-1-git-send-email-sridhar.samudrala@intel.com>
 <1524848820-42258-2-git-send-email-sridhar.samudrala@intel.com>
 <20180428075027.GI5632@nanopsycho.orion>
Message-ID: <9826909e-d6cd-a0a3-142f-6f7f8cf2b5ce@intel.com>
Date: Sun, 29 Apr 2018 19:47:03 -0700
MIME-Version: 1.0
In-Reply-To: <20180428075027.GI5632@nanopsycho.orion>
Content-Type: multipart/alternative;
 boundary="------------964F2933D3EC1565ECA96A01"
Content-Language: en-US
Subject: [virtio-dev] Re: [PATCH net-next v9 1/4] virtio_net: Introduce
 VIRTIO_NET_F_STANDBY feature bit
To: Jiri Pirko <jiri@resnulli.us>
Cc: mst@redhat.com, stephen@networkplumber.org, davem@davemloft.net, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, jesse.brandeburg@intel.com, alexander.h.duyck@intel.com, kubakici@wp.pl, jasowang@redhat.com, loseweigh@gmail.com, aaron.f.brown@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

--------------964F2933D3EC1565ECA96A01
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/28/2018 12:50 AM, Jiri Pirko wrote:
> Fri, Apr 27, 2018 at 07:06:57PM CEST,sridhar.samudrala@intel.com  wrote:
>> This feature bit can be used by hypervisor to indicate virtio_net device to
>> act as a standby for another device with the same MAC address.
>>
>> VIRTIO_NET_F_STANDBY is defined as bit 62 as it is a device feature bit.
>>
>> Signed-off-by: Sridhar Samudrala<sridhar.samudrala@intel.com>
>> ---
>> drivers/net/virtio_net.c        | 2 +-
>> include/uapi/linux/virtio_net.h | 3 +++
>> 2 files changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index 3b5991734118..51a085b1a242 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -2999,7 +2999,7 @@ static struct virtio_device_id id_table[] = {
>> 	VIRTIO_NET_F_GUEST_ANNOUNCE, VIRTIO_NET_F_MQ, \
>> 	VIRTIO_NET_F_CTRL_MAC_ADDR, \
>> 	VIRTIO_NET_F_MTU, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS, \
>> -	VIRTIO_NET_F_SPEED_DUPLEX
>> +	VIRTIO_NET_F_SPEED_DUPLEX, VIRTIO_NET_F_STANDBY
> This is not part of current qemu master (head 6f0c4706b35dead265509115ddbd2a8d1af516c1)
> Were I can find the qemu code?
>
> Also, I think it makes sense to push HW (qemu HW in this case) first
> and only then the driver.

I had sent qemu patch with a couple of earlier versions of this patchset.
Will include it when i send out v10.



--------------964F2933D3EC1565ECA96A01
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    On 4/28/2018 12:50 AM, Jiri Pirko wrote:<br>
    <blockquote type="cite"
      cite="mid:20180428075027.GI5632@nanopsycho.orion">
      <pre wrap="">Fri, Apr 27, 2018 at 07:06:57PM CEST, <a class="moz-txt-link-abbreviated" href="mailto:sridhar.samudrala@intel.com">sridhar.samudrala@intel.com</a> wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="">This feature bit can be used by hypervisor to indicate virtio_net device to
act as a standby for another device with the same MAC address.

VIRTIO_NET_F_STANDBY is defined as bit 62 as it is a device feature bit.

Signed-off-by: Sridhar Samudrala <a class="moz-txt-link-rfc2396E" href="mailto:sridhar.samudrala@intel.com">&lt;sridhar.samudrala@intel.com&gt;</a>
---
drivers/net/virtio_net.c        | 2 +-
include/uapi/linux/virtio_net.h | 3 +++
2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 3b5991734118..51a085b1a242 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2999,7 +2999,7 @@ static struct virtio_device_id id_table[] = {
	VIRTIO_NET_F_GUEST_ANNOUNCE, VIRTIO_NET_F_MQ, \
	VIRTIO_NET_F_CTRL_MAC_ADDR, \
	VIRTIO_NET_F_MTU, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS, \
-	VIRTIO_NET_F_SPEED_DUPLEX
+	VIRTIO_NET_F_SPEED_DUPLEX, VIRTIO_NET_F_STANDBY
</pre>
      </blockquote>
      <pre wrap="">
This is not part of current qemu master (head 6f0c4706b35dead265509115ddbd2a8d1af516c1)
Were I can find the qemu code?

Also, I think it makes sense to push HW (qemu HW in this case) first
and only then the driver.</pre>
    </blockquote>
    <br>
    <pre>I had sent qemu patch with a couple of earlier versions of this patchset.
Will include it when i send out v10.</pre>
    <br>
  </body>
</html>

--------------964F2933D3EC1565ECA96A01--
