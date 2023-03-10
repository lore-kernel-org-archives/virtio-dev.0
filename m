Return-Path: <virtio-dev-return-11603-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92178C64EC4
	for <virtio-dev@archiver.kernel.org>; Fri, 10 Mar 2023 15:06:51 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id D6A8D33576
	for <virtio-dev@archiver.kernel.org>; Fri, 10 Mar 2023 15:06:50 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CC118986766
	for <virtio-dev@archiver.kernel.org>; Fri, 10 Mar 2023 15:06:50 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id C0E2B986721; Fri, 10 Mar 2023 15:06:50 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A708598671E;
	Fri, 10 Mar 2023 15:06:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IMPcvqdr9XDm0it0iGAByyXCaobewIvbe2VvQVSOPwlvj/oNsVb+LMwJ6llHojRpOZhqzIGY9TdWUzbfQN+H+5n3tC2rJW+RYNMIyZDJgV0uCBV8Mkuc4sRAAZX/1ZjxGxL+89cz39qmWdJQF6DmsKQSCvv/wYPXkPMnRcp7tzLibLKqEpil2zUGI9pvOr6qHg9tKVaqYI345Uxr8bQ1aATM+WnrfvmXkkqzBDRmt56ia5Zh43hPLR1emyysyk7FIlOuF8EpYrUwVPYuw3ISqYDnTjEnC1u4x5ydzr8ZinSdCUaom77C+g+k0OE1nFb0h0oK4o91jwUbatTud/CGrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X8sw7Ok14W+UffM97/ZVjWpcng4M8s5TnpO0BEY/jVg=;
 b=drv7PQRG8Ff87FJ5mVfAda1b0+G6q+e/XyHBTYObgs9RajwfbzVOQgTrmMbmTlGYa4VooVm8zLS4OjTikLdvAbmbkKpZgBzhrXf/fqKjK1JcQlLXdNxJX596UZ+IaX9qbJjRrGYX7BsHnSc3//Kc33Xd9fKCdXmU/QVgLskxz3aI+xNK0eBDL8wIx+5hut222IC/fEnKaz9GG4YvnexSAzG59pjPBtwRFybue7LAg30BwHdhj3zOuQ7xM8Pc3kheUY8BH6+IqW8YBjnKSTH4kkw8abwj32t9Fs+YERNsw2KfUeUI78WmnIehHefIywMtEBv5pYrT4g5FWUBd+MCPZw==
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
To: <mst@redhat.com>, <virtio-dev@lists.oasis-open.org>, <cohuck@redhat.com>
CC: <virtio-comment@lists.oasis-open.org>, <shahafs@nvidia.com>, Parav Pandit
	<parav@nvidia.com>
Date: Fri, 10 Mar 2023 17:06:20 +0200
Message-ID: <20230310150620.115188-1-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT014:EE_|IA0PR12MB7674:EE_
X-MS-Office365-Filtering-Correlation-Id: 5df6116d-a972-4a04-dbcd-08db21790eac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qKfmaOAb2GTSkeH10pHnQhAUNZB8PyUn2SySP8TeoFL93jJhIrWFbO2Omfp9ylo16jSs+OnLIz9Y75cIROISBpAn/tWPuthnvGYl6GEpoMXe9rXcp5p+SdzWj8fEkSxXke1ll77CywjfK+DgROwsDF5NZEobP0FyrW7wzz56qJcmIeM54E0Lt15tXlR6zn3HL1Y/rRjV1Jjh3ZtmcqFHtdT+6LQOd1KVuuOt17Is/+IP4QAhJTbfrr3rHfq2wLJ+O9apU16/q1UXv7xM8DwPWJyFe4ylqnmCULEoYmBDDPLXLp4kpSVoN6iT0mmNvfKPhjNI0r2wlx+/tajSZJgMdOyoaYNNCtADy0lw8BMC2Z2fKiFcJGKpUf05/ChdxHkGHN2ovIY8x8droy2MYhs91mfPgNyl79NOI0zJl007GLVql26Jx/CvPJbVgDoKAtdUzNsiK10x+xsut8KnRIVfVLgBSDZv39eydhAR8SWu2I+0AA8I9hsRUxxlPThXw2ZQ5RBF6EUX+XFPYpSCqpSEvGz9/VOrRXm2B3FkQyH578AQkmP6HJnLMCbiaeoA9fSBJgC5Y6pg/zwWff7v3Xf2F9uhEL7r9v3MvHQOxFy6H+XpzU8C1PyZpuHCrWazHvMZtWtzwE7nHXeWjhwLqwmVRWKaIyZpkn3vvsApblrXP2V4rz+dD5SzPb8jjIfZKpf1oLCzrkqO41VDCKGC3iEJf66fD43dOQF8vzmfvB6kvG2E4nu2a/ynlacJ6glQmJBW
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(346002)(39860400002)(396003)(136003)(376002)(451199018)(40470700004)(46966006)(36840700001)(36860700001)(82740400003)(186003)(36756003)(478600001)(54906003)(356005)(110136005)(316002)(86362001)(41300700001)(82310400005)(83380400001)(26005)(426003)(7636003)(6666004)(2616005)(40460700003)(16526019)(336012)(107886003)(2906002)(1076003)(4744005)(70206006)(5660300002)(4326008)(8936002)(8676002)(70586007)(47076005)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 15:06:42.2463
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5df6116d-a972-4a04-dbcd-08db21790eac
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7674
Subject: [virtio-dev] [PATCH] transport-pci: Remove duplicate word structure

Remove duplicate word structure.

Signed-off-by: Parav Pandit <parav@nvidia.com>
---
 transport-pci.tex | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/transport-pci.tex b/transport-pci.tex
index 01fb652..b07a822 100644
--- a/transport-pci.tex
+++ b/transport-pci.tex
@@ -813,7 +813,7 @@ \subsubsection{Legacy Interfaces: A Note on PCI Device Layout}\label{sec:Virtio
 \end{tabular}
 
 Note: When MSI-X capability is enabled, device-specific configuration starts at
-byte offset 24 in virtio common configuration structure structure. When MSI-X capability is not
+byte offset 24 in virtio common configuration structure. When MSI-X capability is not
 enabled, device-specific configuration starts at byte offset 20 in virtio
 header.  ie. once you enable MSI-X on the device, the other fields move.
 If you turn it off again, they move back!
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

