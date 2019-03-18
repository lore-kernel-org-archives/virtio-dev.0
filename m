Return-Path: virtio-return-3321-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Mon, 18 Mar 2019 18:54:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190318225430.16823-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio] [PATCH] block: drop duplicate text
To: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: Gil Savir <gil.savir@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

In version 1.1 draft 01 - Section 5.2.6.4 - second bullet:

Duplicated text "errors, data_len, sense_len and residual MUST reside in
a single, separate device-writable descriptor" appears +both in the
beginning and at the end of the 2nd sentence.

The original text:

For SCSI commands there are additional constraints. errors, data_len,
sense_len and residual MUST reside in a single, separate device-writable
descriptor, sense MUST reside in a single separate device-writable
descriptor of size 96 bytes, and errors, data_len, sense_len and
residual MUST reside a single separate device-writable descriptor.
I suggest to delete the 1st one, so in the end result, fields are
described in same order as appear in struct virtio_scsi_pc_req.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/39
Reported-by: Gil Savir <gil.savir@intel.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 content.tex | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/content.tex b/content.tex
index 05fcb7b..e8536a0 100644
--- a/content.tex
+++ b/content.tex
@@ -4236,9 +4236,7 @@ negotiated VIRTIO_F_ANY_LAYOUT:
   for \field{status}.
 
 \item For SCSI commands there are additional constraints.
-  \field{errors}, \field{data_len}, \field{sense_len} and
-  \field{residual} MUST reside in a single, separate
-  device-writable descriptor, \field{sense} MUST reside in a
+  \field{sense} MUST reside in a
   single separate device-writable descriptor of size 96 bytes,
   and \field{errors}, \field{data_len}, \field{sense_len} and
   \field{residual} MUST reside a single separate
-- 
MST

---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

