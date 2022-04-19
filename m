Return-Path: <virtio-dev-return-9412-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7593598640E
	for <virtio-dev@lists.oasis-open.org>; Tue, 19 Apr 2022 16:30:34 +0000 (UTC)
Date: Tue, 19 Apr 2022 12:30:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20220419163024.134007-1-mst@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH] fixupdiff: escape ^ caret
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: virtio@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

Since commit:

commit 1e30753d53d222fbe955f0643583d756105d557e
Author: Jan Kiszka <jan.kiszka@siemens.com>
Date:   Fri Oct 11 13:43:41 2019 +0200

    Fix ^= in example code

    Trying to escaping ^ here only leaves the backslash in the output.

    Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
    Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

we have plain ^ inside listing. Escape it with \ but only
if not already escaped (as output of diff with old source will be).

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 fixupdiff.pl | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fixupdiff.pl b/fixupdiff.pl
index f50cf26..e7d3a0f 100644
--- a/fixupdiff.pl
+++ b/fixupdiff.pl
@@ -35,6 +35,10 @@ while (<>) {
 		$line =~ s/%DIFDELCMD\s+< //;
 		if (not $line =~ m/\\(?:begin|end)\{lstlisting\}/) {
 			$line =~ s/([#&{} ])/\\$1/g;
+			#be careful: do not escape \^
+			$line =~ s/([^\\])(\^)/$1\\$2/g;
+			#also at beginning of line
+			$line =~ s/^(\^)/\\$1/g;
 			if ($add) {
 				$line =~ s/(.*)/\$\\DIFdel\{$1\}\$/;
 			} else {
-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

