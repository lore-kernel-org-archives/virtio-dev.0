Return-Path: virtio-comment-return-819-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Huang Yang <yang.huang@intel.com>
Date: Mon, 29 Jul 2019 15:48:13 +0800
Message-Id: <1564386494-2296-1-git-send-email-yang.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [virtio-comment] [PATCH] Add virtio rpmb device specification
To: virtio-dev@lists.oasis-open.org
Cc: virtio-comment@lists.oasis-open.org, mst@redhat.com, bing.zhu@intel.com, tomas.winkler@intel.com, Huang Yang <yang.huang@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

This is the virtio-rpmb specification draft, applied to the current
virtio-spec.
 
Below is a short description of RPMB and why we are doing this:
RPMB (Replay Protected Memory Block) is a physical partition in
eMMC, UFS or NVMe.
 
Different from the traditional user partition, RPMB requires
an RPMB authentication key and a monotonic write counter to access it.
Every access to RPMB is in an authenticated and replay protected manner.
 
RPMB access is authenticated by the Message Authentication Code (MAC),
which is a hash value generated based on RPMB authentication key
and the message using HMAC-SHA. The authentication key is programmed
in a secure environment before any access to RPMB. Writer counter is
the total number of successful authenticated data write on RPMB.
It is added by one automatically by RPMB controller after each
successful write operation. It is a required factor in messageto be
MACed together.
 
RPMB is widely used as a tamper-resistant and anti-replay storage.
For example, it’s used in these open source projects:
Google Trusty (https://source.android.com/security/trusty),
ACRN (https://projectacrn.org/),
OP-TEE (https://www.op-tee.org/) and so on.
 
But virtualization software like Qemu doesn't provide eMMC/UFS/NVMe
RPMB emulation. It blocks the OS like Trusty or OP-TEE running in a
virtualization environment. For instance, Google right now uses another
way to work around RPMB emulation issue when running Trusty in ARM Qemu:
https://android.googlesource.com/trusty/external/trusty/+/refs/heads/master/test-runner/

Virtio RPMB standardization will definitely benefit OP-TEE,
Google Trusty TEE, Qemu, OVMF or other modules to develop the RPMB
based secure storage in virtualization.
 
Virtio RPMB has been implemented in ACRN (https://projectacrn.org/).
Virtio RPMB device in ACRN devicemodel:
https://github.com/projectacrn/acrn-hypervisor/blob/master/devicemodel/hw/pci/virtio/virtio_rpmb.c
Virtio RPMB frontend driver in kernel:
https://github.com/projectacrn/acrn-kernel/blob/master/drivers/char/rpmb/virtio_rpmb.c


Huang Yang (1):
  Add virtio rpmb device specification

 conformance.tex | 18 +++++++++++-
 content.tex     |  3 ++
 virtio-rpmb.tex | 88 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 108 insertions(+), 1 deletion(-)
 create mode 100644 virtio-rpmb.tex

-- 
2.7.4


This publicly archived list offers a means to provide input to the
OASIS Virtual I/O Device (VIRTIO) TC.

In order to verify user consent to the Feedback License terms and
to minimize spam in the list archive, subscription is required
before posting.

Subscribe: virtio-comment-subscribe@lists.oasis-open.org
Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
List help: virtio-comment-help@lists.oasis-open.org
List archive: https://lists.oasis-open.org/archives/virtio-comment/
Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
Committee: https://www.oasis-open.org/committees/virtio/
Join OASIS: https://www.oasis-open.org/join/

