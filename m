Return-Path: <virtio-dev-return-12328-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 910CAC77B7C
	for <virtio-dev@archiver.kernel.org>; Thu, 20 Apr 2023 19:52:44 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id E956A60086
	for <virtio-dev@archiver.kernel.org>; Thu, 20 Apr 2023 19:52:43 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DF542986676
	for <virtio-dev@archiver.kernel.org>; Thu, 20 Apr 2023 19:52:43 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id D4A0D98663B; Thu, 20 Apr 2023 19:52:43 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A7EF4986647;
	Thu, 20 Apr 2023 19:52:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DvtKeN50ssJ6NIk4bXr4oDuT5iVbgEpw/ruY9YqESK45Ew4+dhzkelmlN0/Rau3A/igLyOv9C9D2PWPK5YnXfX5jSa4mwaGKQkQphOithnlWX5rrII4PqvcoXNYjvBsCbDT9mYOPJxs5T/xyyYfnbWVXoamvgSzL25Ix5G7MHwo2wqYRhllXChhOCpkTjhPzUqW479ipwhZOTlyFQRqcabr5Qs4LX68fbBwN9aNh2yjN8JkEWu/4912vepisqzFFXRfDJxKS/3Hf9mzm2Tqg5vok6lJyhLKDsjGewKqjJn4Qzf+t8sDt+h0R+awPZFECC9IVl02N7EC3VP/UT1engQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mzAjUWYx1zyjmjgJm29XFF2BmYtei7mD/vT4BDRrcII=;
 b=EQPiBk1R+fEsLjrKC1NUqm/m1sPz/cq5Jnxu1vNZjlscJQuhwGKKAxzeh0zWR5HSVdaDJnq+PuOwNc49zXr1XjsEauxAZIu5k/lBhqhgWqHtWdhnqTJUYe98eiV5dVqVzW+DQ50NXI5uVMIWzG2YFlgZRyteazBDQa/OxsRSgeQDra8JKqGr2qla5MDhZoBp4/OcZruzw0vB4JvA4ZRhMMo1ygkd5To8rFFh03bzUWbxbGTTOEPDQ1ml80oseWYg1XqBjbByFeMDkVNEGCecbzK/uBIu0f+Zz+/ave79Nd6JJjgOU+7Jj8vX4G6cqwQBxhK3t3HXWt6TJvl6fxX9Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
From: Parav Pandit <parav@nvidia.com>
To: <mst@redhat.com>, <virtio-dev@lists.oasis-open.org>,
	<pasic@linux.ibm.com>, <cohuck@redhat.com>
CC: <virtio-comment@lists.oasis-open.org>, <shahafs@nvidia.com>, Parav Pandit
	<parav@nvidia.com>
Date: Thu, 20 Apr 2023 22:51:56 +0300
Message-ID: <20230420195158.69737-1-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000145BA:EE_|DM6PR12MB4041:EE_
X-MS-Office365-Filtering-Correlation-Id: 49e26757-defe-4d12-3f87-08db41d8c0e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	g8Zv7RWPuv9zwiVs1dUQsOxX94RZgzRB+dEGu6l+pQeHzyw/G8VTTswpXoszHAU4NgbT/47CHaoTznJrrEVkY8oOrVj3gJ8ySueMSUjtX9FdNYpA8KoyWNYW5Uo3nwpZKeXsh+xfxRENNR3i6n+Y2lCTSMtCZ8lBzkjJqpjuE1gxlJcSX+8KUcFmZCZX9EWUfA5wP7/RuyJwKdczNKt+Af6WOujg+Pao1Sy2UVHewI1N97N+JOss/nfQTmPmP0rnNn9r8ssdnIZGr7JqXSiB6RzrUW5KlkEYDkbE/ZcC3tVFIhUGmG7c0LyswW+f00y4Uy1c/AuFbz6RlC6r0yXVF02/yiBoMQNHYALWVyXCZBRNsOGf5HVncX6w5oB1D9SlBYDIgEkZ9IqRAR17SH8kiWWBXmYFE5suTtMCvTVAWANYStt5w2nuQ7x1O+xpdOkP5ou4w5cB5hMCXprcXpPoE+8ROhy17/B0PQWap12UgpO95z5m+IJx/4FLpoyjotTODLm7DgGsD0mWZYANUCpO4Cyz73pQ3+Ha/WtbxfBDpiBcGfU5gmKsjLjnjslwTaEI8EsmpiFpxDImT28G2Aa1SNY4hHvnAsE3uDL4bkItevXWx30uWLtT77e8A4nGqNP2N4TE17MdfRQB16UhHrm3wYDf3lIDO6RYo86zC04glUY+Ov33iEMCaWoMlbEgnsYnCdmMuhfjvldEp+/OUC4GMZw3HQVXYnn4na7utir5lvXuEZlinjlEPRabARdawq3D
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(136003)(346002)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(40460700003)(6666004)(478600001)(7636003)(1076003)(356005)(82310400005)(82740400003)(2616005)(107886003)(186003)(16526019)(26005)(47076005)(426003)(83380400001)(336012)(36860700001)(4326008)(86362001)(54906003)(110136005)(70586007)(36756003)(40480700001)(8676002)(41300700001)(8936002)(70206006)(316002)(2906002)(4744005)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 19:52:20.6304
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49e26757-defe-4d12-3f87-08db41d8c0e7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF000145BA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4041
Subject: [virtio-dev] [PATCH 0/2] transport-pci: msix register desc improve

Problem:

Current wording queue_msix_vector and config_msix_vector says
"for MSI-X", which is bit confusing.

config_msix_vector and queue_msix_vector are the msix vector
number for configuration change and queue related interrupts.

Hence, reword it.

---
changelog:
v1->v2:
- rewrote to indicate MSI-X table entry index
v0->v1:
- added 'here'
- dropped 'receiving'
- dropped already merged patch for empty line


Parav Pandit (2):
  transport-pci: Improve config msix vector description
  transport-pci: Improve queue msix vector register desc

 transport-pci.tex | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

