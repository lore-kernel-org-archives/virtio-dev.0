Return-Path: virtio-dev-return-6020-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D5B66985BE4
	for <virtio-dev@lists.oasis-open.org>; Wed, 28 Aug 2019 07:16:08 +0000 (UTC)
From: Huang Yang <yang.huang@intel.com>
Date: Wed, 28 Aug 2019 15:21:17 +0800
Message-Id: <1566976878-14357-1-git-send-email-yang.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] [PATCH v4 0/1] Add virtio rpmb device specification
To: virtio-dev@lists.oasis-open.org
Cc: mst@redhat.com, cohuck@redhat.com, bing.zhu@intel.com, tomas.winkler@intel.com, peter.fang@intel.com, Huang Yang <yang.huang@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

The RPMB authentication key is owned by the user (normally it’s a TEE or other TCB)
who calls virtio rpmb driver, but not owned by the virtio rpmb driver.
As a result, the user is in charge of calculating the MAC, packing the RPMB frame
and sending it to the driver.
Any changes on RPMB frame definition, including order, size, crypto algorithm will cause
to a different MAC.
If the frame definition is changed, it indicates software has to recognize it’s running
on a VM or not, and to maintain two different implementations to adapt virtio RPMB device
and hardware RPMB device.
In order to keep compatibility with native usage, keeping the definition of virtio RPMB
frame same as the hardware specification is perferred. 

struct virtio_rpmb_frame {
        u8 stuff[196];
        u8 key_mac[32]; <------------------------------
        u8 data[256]; ---------------->|                       ^
        u8 nonce[16]; ---------------->|                      ^
        be32 write_counter; -------->|             HMAC-SHA256()
        be16 address; ---------------->|-------------> | <-----------Authentication Key
        be16 block_count; ---------->|
        be16 result; ------------------>|
        be16 req_resp; -------------->|
};

v3 -> v4:
1. Remove multiple RPMB targets.
2. Remove NVMe RPMB.
3. typo fix.
4. Some wording changes for better understanding.
5. Add conformance.

v2 -> v3:
1. Remove conformance changes temporarily
   since the draft requires reviews and updates at this phase.
2. Add eMMC, UFS and NVMe as Normative References.
3. Add more details on:
   RPMB frame
   Request Type/Response Type
4. Add differentiation JEDEC RPMB and NVMe RPMB.
5. Define config layout
6. Illustrate behaviors of all RPMB requests 7. Remove RPMB device ID reservation,
   it will be submitted with an independent patch.

v1 -> v2:
1. update conformance.
2. wordings change:
   first initialization -> first device initialization
   device size -> device capacity
3. update Device Operation:
   add more decriptions on write counter, key and write operations.

Huang Yang (1):
  Add virtio rpmb device specification

 conformance.tex  |  20 ++++-
 content.tex      |   1 +
 introduction.tex |   6 ++
 virtio-rpmb.tex  | 238 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 264 insertions(+), 1 deletion(-)
 create mode 100644 virtio-rpmb.tex

-- 
2.7.4


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

