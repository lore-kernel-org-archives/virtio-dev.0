Return-Path: <virtio-dev-return-11763-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ABD0C74A5B
	for <virtio-dev@archiver.kernel.org>; Fri, 24 Mar 2023 01:36:11 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 95F473E30D
	for <virtio-dev@archiver.kernel.org>; Fri, 24 Mar 2023 01:36:05 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8BB8F9864F3
	for <virtio-dev@archiver.kernel.org>; Fri, 24 Mar 2023 01:36:05 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 80C1198644A; Fri, 24 Mar 2023 01:36:05 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6D00C986474;
	Fri, 24 Mar 2023 01:36:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CeM6uWh2OMiGL/Ngc/afNRTQ+ztThXwEG8H3vIZaWGOyX5N99a7PD0+418a2ZipOIZJ7JDY0oBqHmn8vXoz4XOHtsEwBTD0UfoD0ba0IhErp4QxooWjcyzhIPOhfXDwB+LWhUwVrfJUYXda/Q5qYqUUuj553MLqMqYP3CLnsdfpxeafxn4TM03wCqfc98JuBRLxCJcbguWzrmarYDsFSdQtePrMx8g0WSLbItgOw1a84M3OskwYzluT8IHaD3yIT1UrhUOqowMV3B0LWeEQmt6HhW8HuitEfrlFHvdeEkiAS6srf0mbjFCRa2BTPDITqCD9pTug3Znfmj6tDPcLvNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0p4u2R8LYOTFd/66tnvi1wlFiXKDOtsyP2BAhhhAD80=;
 b=LQgP84edhqq72jGEZgkvnpGYjae+6fqMbuUVQlteosF90+nIqxQcIpeHEbcKY2AT4n5FP/+rDjrsdRPzs0MzkvgT0UiRaxytDcKhmiI8whLF5pmzXWV6lirwVWaxuYAYcFFXQ73jqDl123SfRQ7Gzgvms7HD255uB33u3uVdYnUBjPNGqsKXJZZcJ9KaMmNTG+gTD+dN91ZRKsIGJG7hCOeTpoctB3zojZNWqC7hts4Fj9aBJAKGRirjb3LHBPBx+oqqHGRtsb0+ZivY50B82KPXFwW4ZjFAiGyDUeEgZNtCK1f2sOzyPzoQjnor0o+bRze8UoL4aAsMjBIzLpPgng==
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
	<parav@nvidia.com>
Date: Fri, 24 Mar 2023 04:35:31 +0300
Message-ID: <20230324013534.280820-1-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT114:EE_|MW4PR12MB7167:EE_
X-MS-Office365-Filtering-Correlation-Id: c14f27b1-ddfe-4cf1-7530-08db2c081eaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	B808RfN3t7tO3ug3pB04pIYOoHiYeJ6+UzuRU0OmHuNnatyd/fTsxx/XPszWkyBKWuuWOjaNwx/yEhEmWt7pbUsW8wM1gOjjwoweyHRDd/n4gu5JvHtv7X2WeXIx2kKSz7G5Pl3h7WapD0uSY9EoCmKaKZ93UdkxwxjBJD0WPCM3siQOwRlthsA7O5O3jvA8Vnst5mGAwsTNAZLAGVa60a0QWjNzFJGd3H2tLTNF1vJYe9udZJ8gTPsyxoNtEzUc+wtjDXRaNYflOmIdVJ2Zb6tHVf/pDBgvyo7rO4qHlMWJSOydipxyHJiTYZ+IOGvCjYKOR2c7Dy8t6t8wppgJVcAYa1yf+U0TRBZkZP5GcmNjd7RNnNEMPh/ql973c6liJSth9FZbIMzhAzmNa6vMgdVhnjVxqNNhbo2Upjc3bBKEeraPg4OLtE+Ykak6r9egzN3vD9YmAb7k9kn51Ut284RtIAMoe4PX8ADdhWHrxNUnB2MEUzKHFqQJB2iJaaLslKute0jF1sikkW5A7rJ1Seva/M99h5R93X2zykUNasK0Y4Pv4qlwa52u+V6TTbGNSAoGxGAAMLN8J/g4XskeGnicWSS4wWCrDMLXjpCnLv5bWpYXytEuoOX7V3i/VruJ0rRaqLYcbWq12a1yWQMwpIjkV0d01K3SKvz/N3ESqO0JaAZ4W0F3ADA74J4pLjMifR+CJkZSJAgnnS8Pq62Yydu4Cwx+RCKzUSc4/IlVj0Y7k8OLXSN/httfnv/Kr7BT
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(39860400002)(346002)(376002)(451199018)(46966006)(40470700004)(36840700001)(41300700001)(5660300002)(4326008)(8676002)(2906002)(4744005)(40460700003)(15650500001)(36860700001)(82740400003)(86362001)(356005)(7636003)(36756003)(107886003)(26005)(1076003)(6666004)(70206006)(316002)(110136005)(70586007)(478600001)(82310400005)(40480700001)(47076005)(8936002)(54906003)(426003)(83380400001)(2616005)(16526019)(186003)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 01:35:58.6717
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c14f27b1-ddfe-4cf1-7530-08db2c081eaa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT114.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7167
Subject: [virtio-dev] [PATCH 0/3] transport-pci: msix summary update

Summary for config_msix_vector and queue_msix_vector
registers have a confusing text of "for MSI-X".

Rewrite the register summary line.

Patch summary:
patch 1 removes empty line at the end of the file
patch 2 updates configuration vector summary
patch 3 updates queue vector summary

These are only editorial changes to rewrite the summary.
Hence it should not require a github issue.

Parav Pandit (3):
  transport-pci: Remove empty line at end of file
  transport-pci: Improve config msix vector description
  transport-pci: Improve queue msix vector register desc

 transport-pci.tex | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

