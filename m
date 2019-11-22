Return-Path: virtio-dev-return-6369-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 727AA985FD5
	for <virtio-dev@lists.oasis-open.org>; Fri, 22 Nov 2019 10:50:59 +0000 (UTC)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
Date: Fri, 22 Nov 2019 11:49:51 +0100
Message-Id: <20191122105000.800410-5-jean-philippe@linaro.org>
In-Reply-To: <20191122105000.800410-1-jean-philippe@linaro.org>
References: <20191122105000.800410-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Subject: [virtio-dev] [RFC 04/13] ACPI/IORT: Add node categories
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
To: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, virtualization@lists.linux-foundation.org, linux-pci@vger.kernel.org, virtio-dev@lists.oasis-open.org
Cc: rjw@rjwysocki.net, lenb@kernel.org, lorenzo.pieralisi@arm.com, guohanjun@huawei.com, sudeep.holla@arm.com, gregkh@linuxfoundation.org, joro@8bytes.org, bhelgaas@google.com, mst@redhat.com, jasowang@redhat.com, jacob.jun.pan@intel.com, eric.auger@redhat.com, sebastien.boeuf@intel.com, kevin.tian@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

The current node filtering won't work when introducing node types
greater than 63 (such as the virtio-iommu nodes). Add
node_type_matches() to filter nodes by category.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/acpi/iort.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/iort.c b/drivers/acpi/iort.c
index 9c6c91e06f8f..1d43fbc0001f 100644
--- a/drivers/acpi/iort.c
+++ b/drivers/acpi/iort.c
@@ -18,10 +18,10 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
=20
-#define IORT_TYPE_MASK(type)=09(1 << (type))
-#define IORT_MSI_TYPE=09=09(1 << ACPI_IORT_NODE_ITS_GROUP)
-#define IORT_IOMMU_TYPE=09=09((1 << ACPI_IORT_NODE_SMMU) |=09\
-=09=09=09=09(1 << ACPI_IORT_NODE_SMMU_V3))
+enum iort_node_category {
+=09IORT_MSI_TYPE,
+=09IORT_IOMMU_TYPE,
+};
=20
 struct iort_its_msi_chip {
 =09struct list_head=09list;
@@ -38,6 +38,20 @@ struct iort_fwnode {
 static LIST_HEAD(iort_fwnode_list);
 static DEFINE_SPINLOCK(iort_fwnode_lock);
=20
+static bool iort_type_matches(u8 type, enum iort_node_category category)
+{
+=09switch (category) {
+=09case IORT_IOMMU_TYPE:
+=09=09return type =3D=3D ACPI_IORT_NODE_SMMU ||
+=09=09       type =3D=3D ACPI_IORT_NODE_SMMU_V3;
+=09case IORT_MSI_TYPE:
+=09=09return type =3D=3D ACPI_IORT_NODE_ITS_GROUP;
+=09default:
+=09=09WARN_ON(1);
+=09=09return false;
+=09}
+}
+
 /**
  * iort_set_fwnode() - Create iort_fwnode and use it to register
  *=09=09       iommu data in the iort_fwnode_list
@@ -397,7 +411,7 @@ static int iort_get_id_mapping_index(struct acpi_iort_n=
ode *node)
=20
 static struct acpi_iort_node *iort_node_map_id(struct acpi_iort_node *node=
,
 =09=09=09=09=09       u32 id_in, u32 *id_out,
-=09=09=09=09=09       u8 type_mask)
+=09=09=09=09=09       enum iort_node_category category)
 {
 =09u32 id =3D id_in;
=20
@@ -406,7 +420,7 @@ static struct acpi_iort_node *iort_node_map_id(struct a=
cpi_iort_node *node,
 =09=09struct acpi_iort_id_mapping *map;
 =09=09int i, index;
=20
-=09=09if (IORT_TYPE_MASK(node->type) & type_mask) {
+=09=09if (iort_type_matches(node->type, category)) {
 =09=09=09if (id_out)
 =09=09=09=09*id_out =3D id;
 =09=09=09return node;
@@ -458,8 +472,8 @@ static struct acpi_iort_node *iort_node_map_id(struct a=
cpi_iort_node *node,
 }
=20
 static struct acpi_iort_node *iort_node_map_platform_id(
-=09=09struct acpi_iort_node *node, u32 *id_out, u8 type_mask,
-=09=09int index)
+=09=09struct acpi_iort_node *node, u32 *id_out,
+=09=09enum iort_node_category category, int index)
 {
 =09struct acpi_iort_node *parent;
 =09u32 id;
@@ -475,8 +489,8 @@ static struct acpi_iort_node *iort_node_map_platform_id=
(
 =09 * as NC (named component) -> SMMU -> ITS. If the type is matched,
 =09 * return the initial dev id and its parent pointer directly.
 =09 */
-=09if (!(IORT_TYPE_MASK(parent->type) & type_mask))
-=09=09parent =3D iort_node_map_id(parent, id, id_out, type_mask);
+=09if (!iort_type_matches(parent->type, category))
+=09=09parent =3D iort_node_map_id(parent, id, id_out, category);
 =09else
 =09=09if (id_out)
 =09=09=09*id_out =3D id;
--=20
2.24.0


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

