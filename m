Return-Path: <virtio-dev-return-11764-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98416C6FD1C
	for <virtio-dev@archiver.kernel.org>; Fri, 24 Mar 2023 01:36:17 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 5D6F777FC
	for <virtio-dev@archiver.kernel.org>; Fri, 24 Mar 2023 01:36:11 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 540589864B0
	for <virtio-dev@archiver.kernel.org>; Fri, 24 Mar 2023 01:36:11 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 499CC986460; Fri, 24 Mar 2023 01:36:11 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 275F99865A8;
	Fri, 24 Mar 2023 01:36:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lGZlrIl3baq0Qki75ttz71WMwJoPFGo+5rBeMnzP4vuvE+4bYurlPWle7so9uhTcd6pS/NedaIIwFT/vRUgwHZYjBhT+cUfKq1uWMtrs/HdEZjeEbhaqkKoY1VXO+ET0Y7zuFaTe0k2d/q2OnQQJamyKeM+dJSNO6j15igJieDPMOFynivDWSs0BxLruYHIPr9qgI9IcDc9vPw9iYRvGl9x1YR65bPRQQBONa2J2DIwczo2hUPaat/fQ3hjz2pnRi3/3eNBzfrhdD2SnBojI0EiK6hmpODeznFEpEDXsj6kXu8dcPlLlbyTIbMA7q9wciUn0jwV7mBnJUfaZvf03mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QK/Tut9fVG2rXG4Z4ocHUoTpbXdXpGkiDUeOkxhLkyg=;
 b=L7g4s5cQs8fyDPeounnnfoAGW3jB8QPtyF9m+lTDLm8p0uTKYGE6xyAvdwU9r4utqy9xwKy/m/mr9L/CwzMzeS42ZI+xTCDAqKYAqyhdkvU4V90cGm2PSV18rbHKhO/YjjiPdWRlSib4+JHUKQgVebuH67UAMhHDMuUL46PVpPSEAm39xBD+g6CVYsD5TycSwofmU5EfwdeX6Gyytv+wj4shC9aJev5tGZgO++kmzMDK5DBWev4MULHbi26+IvHHkapiytB24sk5N5Yn+eugvInctcqcrugEBu/v8BZBXpxOYiDYtxsHfk9+EgUxYnQdCgn580RIdwn6oa7E4XLClw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
From: Parav Pandit <parav@nvidia.com>
To: <mst@redhat.com>, <virtio-dev@lists.oasis-open.org>,
	<pasic@linux.ibm.com>, <cohuck@redhat.com>
CC: <virtio-comment@lists.oasis-open.org>, <shahafs@nvidia.com>, Parav Pandit
	<parav@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Date: Fri, 24 Mar 2023 04:35:33 +0300
Message-ID: <20230324013534.280820-3-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230324013534.280820-1-parav@nvidia.com>
References: <20230324013534.280820-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT114:EE_|BY5PR12MB4919:EE_
X-MS-Office365-Filtering-Correlation-Id: 232b99a1-4722-4583-77a2-08db2c081fb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	B62W+09E7jJsY1GCAKGG8BGG7YxGx/twkRgh4V54vyxwke2QzKMyf+XEKJqKyTawVGHE8rRztUWr9ZI1sn8eUx8KtzlTTg+ZX/Vv1ZYb6jR2OBADkheSy0cCVEBqPs25BcnZRyU9y0tHI/GPmMXTqoFFXz3qiYhNKtotT+cfnx6QJDhEcB7Jn3FMmFeg17onbTnJE/gqvDY6H7zNXZ4KTV/Gh+ipfXn1zYw79FbBqe8prqnbtBbzHtbyyFazvXV3Mq4phtY7Oqz3wBOZdDc0nzpUM9aTou9Fbk4mdD2t0fQQuRAdD3g/nUieJw/C4x6IT0AmI5GGnx2YeD7+jSjzonV8wjO7NBz+35ynCkIXxO8I764XoEULNwDOvNximAFDWKKdslk+d+nq6Evf8484ZJ9CMYh8AUl8os3XinEe+B364+S5+Hut7JlD6SLbUHaJ+04HWwsj2PummEF6TAjAstm0QRtxOgzdmnG4x/UUbugrXXfXrbu8pdxf8QD5dHEAUES+NEuSdV2Dw1o5dyjzleGyvp1ND+cC7ZUE62j94PhH+XN8grJhaU7b1XqlGHKXBcrT3qk1axll9NVryPr7nx9COWQCiMOZc863nk3Pr5ZyXcMDkYH9BIpPLeHKOfvW2ew8OR54O9diWJhb9xAkA/ciTYMV8znjxE0v7iHQf+VXw2q1Ud6fV+f0P9yDKfy3hKIolwRF99xTjinxpevRPddJoQQSr0vxdm7g6kndLII=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(396003)(39860400002)(136003)(451199018)(46966006)(36840700001)(356005)(40480700001)(2906002)(83380400001)(478600001)(336012)(16526019)(186003)(2616005)(82310400005)(86362001)(36756003)(110136005)(70206006)(54906003)(4744005)(8676002)(36860700001)(4326008)(1076003)(70586007)(5660300002)(6666004)(8936002)(426003)(107886003)(47076005)(26005)(316002)(82740400003)(7636003)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 01:36:00.4372
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 232b99a1-4722-4583-77a2-08db2c081fb5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT114.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4919
Subject: [virtio-dev] [PATCH 2/3] transport-pci: Improve config msix vector description

config_msix_vector is the register that holds the MSI-X vector number
for receiving configuration change related interrupts.

It is not "for MSI-X".

Hence, replace the confusing text with appropriate one.

Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
 transport-pci.tex | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/transport-pci.tex b/transport-pci.tex
index 6e0cb45..1bc89b4 100644
--- a/transport-pci.tex
+++ b/transport-pci.tex
@@ -343,7 +343,8 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
         Driver Feature Bits selected by \field{driver_feature_select}.
 
 \item[\field{config_msix_vector}]
-        The driver sets the Configuration Vector for MSI-X.
+        The driver writes an MSI-X vector number for receiving
+        Configuration change interrupts.
 
 \item[\field{num_queues}]
         The device specifies the maximum number of virtqueues supported here.
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

